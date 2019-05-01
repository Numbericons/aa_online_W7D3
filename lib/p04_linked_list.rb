require 'byebug'
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
    @next, @prev = nil, nil
  end
end

class LinkedList
  include Enumerable
  attr_reader :head
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first #next would be nil if the next element from head is the tail
    @head.next
  end
  
  def last #prev would nil if the previous ele is the head
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    curr_node = @head
    until curr_node.next == nil 
      curr_node = curr_node.next
      return curr_node.val if curr_node.key == key
    end
    nil
  end

  def include?(key)
    curr_node = @head
    until curr_node.next == nil
      curr_node = curr_node.next
      return true if curr_node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key,val)
    new_node.next = @tail
    new_node.prev = @tail.prev
    
    @tail.prev.next = new_node

    @tail.prev = new_node
  end

  def update(key, val)
    curr_node = @head
    until curr_node.next == nil
      curr_node = curr_node.next
      if curr_node.key == key
        curr_node.val = val
        break
      end
    end
  end

  def remove(key)
    curr_node = @head
    until curr_node.next == nil
      curr_node = curr_node.next
      if curr_node.key == key
        curr_node.remove
        break
      end
    end
  end

  def each
    curr_node = @head
    until curr_node.next.next == nil
      curr_node = curr_node.next
      yield(curr_node)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
