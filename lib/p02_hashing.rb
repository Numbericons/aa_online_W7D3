

class Integer
 
  # Integer#hash already implemented for you
end

class Array
  def hash
    #use rubys int hash method to convert an array into a random string of numbers
    result = 0
    self.each_with_index do |el,i|  #["a".to_i + 0, "p".to_i + 1, "p".to_i + 2]
     
      sub = el.hash + i.hash #el is now a char/string
      result = result + sub.hash
    end
    return result
  end
end
# [1,2,3].hash => 48392042

# [3,4].hash   # (3 + 0).hash  => 88  (4  + 1).hash  => 99
# [4,3 ].hash  #(4 + 0).hash  => 55   (3 + 1).hash  => 55
# 3.hash = 7 
# 0.hash = 1
# 1.hash = 4
# 4.hash = 8
# sum = 20 
# 0 = 0 + 1.hash + 0.hash
# result = 579 + 432

class String
  def hash
    # alpha = ("a".."z").to_a
    # ret = []
    
    new_arr = self.chars #["a","b","c"]
     new_arr.map!(&:ord) #[ "a"= 2381273 "b" = 1223413] # ord generates a value for a given element 
      # print new_arr
     new_arr.hash #takes array of nums and hashes array into a single numnber

    # self.split('').hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    # p self
    # arr = self.to_a
    # self.to_a.sort.hash   flatten
    #need to convert sym, string, arr, hash to int before calling Array#hash
    # return 0 unless self.length > 0
    result = self.to_a.sort.hash #[ ["cheese", 18], ["string", 22] ] = [ 23554, 234322 ]
    return 0 unless result
    result
  end
end

#{"key" => 2}
#[ ["key" , 2] ]
   # 45353456
