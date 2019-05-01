require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max){false}  #max - 1
    @max = max
  end

  def insert(num)
    raise "Out of bounds" if !is_valid?(num) || num < 0
    raise 'Already exists in array' if include?(num)
    @store[num] = true
  end

  def remove(num)
    raise "not valid" unless is_valid?(num)
    raise 'doesnt exist in array' unless include?(num)
    @store[num] = false
  end

  def include?(num)
    raise "not valid" unless is_valid?(num)
    @store[num]  #if not include, return false. If included, return true
  end

  private

  def is_valid?(num)
    num <= @max
  end

  def validate!(num)
  end

end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num) #num = 2
   self[num] << num  #self[num]  => @store[num % num_buckets]
  end

  def remove(num)
    # debugger
    self[num].delete(num) # Array#delete  -- looks for and removes first ele to match arg
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
   # optional but useful; return the bucket corresponding to `num
   @store[num % num_buckets]
  end

  # def []=(num,arg)
  #  @store[num % num_buckets] = arg
  # end

  def num_buckets
    @store.length
  end

  # def []=(pos, mark)
  #   x, y = pos
  #   @grid[x][y] = mark
  # end
end

class ResizingIntSet
  attr_reader :store
  attr_accessor :count

  def initialize(num_buckets = 20)
  
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
   
  end

  def insert(num)
    return nil if include?(num)
    @count += 1
    self[num] << num
    # debugger if @count > num_buckets 
    if @count > num_buckets #changed from >=
     
      resize!
    end
  end

  def remove(num)
    return nil if !include?(num)
    @count -= 1
    self[num].delete(num)
  end
  
  def inspect
    "#{self.store}, count = #{self.count}" 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
      @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!   #array doubles in size,  perform a modulo to resize
    reset_els = @store.flatten  #previous elements (number % 20 determined buckets)   #[[][1][2,7][][4]] 
    resized_buckets = num_buckets * 2
    @store = Array.new(resized_buckets) { Array.new }    #  [[][][][][]]  +  [[][][][][]]   = 
    reset_els.each do |el|
     self[el] << el
    end
  end
   # [[1][2][3][][]] => [1,2,3]      #3    =
end
