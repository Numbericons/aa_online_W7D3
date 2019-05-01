class HashSet
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return nil if include?(key)
    @count += 1
    self[key] << key
    # debugger if @count > key_buckets 
    if @count > num_buckets #changed from >=
     
      resize!
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return nil if !include?(key)
    @count -= 1
    self[key].delete(key)
  end

  def inspect
    "#{self.store}, count = #{self.count}" 
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
   
    
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    # @count = 0
    reset_els = @store.flatten  #previous elements (number % 20 determined buckets)   #[[][1][2,7][][4]] 
    resized_buckets = num_buckets * 2
    @store = Array.new(resized_buckets) { Array.new }    #  [[][][][][]]  +  [[][][][][]]   = 
    reset_els.each do |el|
     self[el] << el
    end
    # @count = 20
  end
end
