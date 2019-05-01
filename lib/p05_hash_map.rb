require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store.any? { |linked_list| linked_list.include?(key) }
  end

  def set(key, val)
    if bucket(key).include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count+=1
    end
    resize! if @count > num_buckets
  end

  def reset(key, val)
    if bucket(key).include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
    end
    resize! if @count > num_buckets
  end
  
  def get(key)
    bucket(key).get(key)
  end
  
  def delete(key)
    bucket(key).remove(key)
    @count-=1
  end

  def each
    @store.each do |link_list|
      curr_node = link_list.head.next
      until curr_node.next == nil 
        yield(curr_node.key, curr_node.val)
        curr_node = curr_node.next
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    reset_els = @store.flatten
    resized_buckets = num_buckets * 2
    @store = Array.new(resized_buckets) { LinkedList.new }
    # @count = 0
    reset_els.each do |linked_list|
      curr_node = linked_list.head.next
      until curr_node.next == nil 
        reset(curr_node.key, curr_node.val)
        curr_node = curr_node.next
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
