module Enumerable

  def my_each
    return to_enum unless block_given?
    each { |element| yield(element) }
  end

  def my_each_with_index
    return to_enum unless block_given?
    counter = 0

        for i in self
            yield i, counter
            counter += 1
        end
  end

  def my_select 
    return to_enum unless block_given?
    result = []
    self.my_each { |i| result << i if yield(i) }
    result
  end

  def my_all? 
    cnt_true = 0
    for i in self
      if block_given?
        cnt_true += 1 unless yield(i)
      else
        cnt_true += 1 unless i
      end
    end
    return cnt_true == 0 ? true : false
  end

  def my_any? 
    any = 0

    for i in self
      if block_given?
        any += 1 if yield(i)
      else
        any += 1 if (i != false and not i.nil?)
      end
    end
    return (any == 0) ? false : true
  end

  def my_none? 
    if block_given?
      self.my_each do |i|
        if yield(i)
          return false
        end
      end
      return true
    else
      self.my_each do |i|
        if i != false && i != nil
          return false
        end
      end
      return true
    end
  end

  def my_count(number = true)
    my_count = 0
    if block_given? 
      self.my_each do |i|
        if yield(i)
          my_count += 1
        end
      end
      my_count 
    else
      self.my_each do |i|
        if i == number
          my_count += 1
        end
      end
      if number == 0
        return self.length 
      else
        return my_count 
      end
    end 
  end

  
end


include Enumerable

array1 = ['hi', 34, 'potatoes', 'horses', 33]
array2 = [2, 7, 8, 5]
hash = { a: 1, b: 2, c: 3, d: 4, e: 5 }
block = proc { |num| num }
my_proc = proc { |num| num > 10 }
range = (5..10)


# puts "\nmy_each output\:"; puts ''
# array1.my_each { |item| puts item }
# p array2.each { |item| item }
# p array2.my_each(&block)
# range.my_each { |item| puts item }
# p range.my_each(&block)
# (hash.my_each { |item, index| puts "#{item} : #{index} " })
# p hash.my_each(&block)

# puts "\nmy_each_with_index output\:"; puts ''
# array1.my_each_with_index { |item, index| puts "#{item} : #{index} " }
# p array2.my_each_with_index { |item, index| "#{item} : #{index} " }
# p array2.my_each_with_index(&block)
# range.my_each_with_index { |item| puts item }
# p range.my_each_with_index(&block)
# hash.my_each_with_index { |item, index| puts "#{item} : #{index} " }

# puts "\nmy_select output\:"; puts ''
# puts array1.my_select { |item| item.to_s.length > 2 }
# p array2.my_select { |item| item }
# range.my_select { |item| puts item }

# puts ''; puts "\nmy_all? output\:"; puts ''
# puts (%w[lul what potatoes uhh].my_all? { |word| word.length >= 3 })
# puts (['lul', 'what', 'potatoes', 'uhh', nil].my_all?)
# puts ([1, 2, 3].my_all?)
# puts (%w[hi hello hey].my_all?)
# p [1, false, 'hi', []].my_all?
# puts ([3, 3, 3].my_all?)

# puts ''; puts "\nmy_any? output\:"; puts ''
# puts %w[ant bear cat].my_any? { |word| word.length >= 3 }
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 }
# puts range.my_any?
# puts [].my_any?
# puts [nil].my_any?
# puts [nil, false].my_any?
# puts ([1, 2, 3].my_any?)
# puts (%w[hi hello hey].my_any?)
# puts ([3, 3, 3].my_any?)

# puts ''; puts "\nmy_none? output\:"; puts ''
# puts %w[ant bear cat].my_none? { |word| word.length == 5 }
# puts %w[ant bear cat].my_none? { |word| word.length >= 4 }
# puts range.my_none?
# puts [].my_none?
# puts [nil].my_none?
# puts [nil, false].my_none?
# puts [1, 2, 3].my_none?
# p [nil, false, nil, false].my_none?
# puts %w[hi hello hey].my_none?# false
# puts [3, 3, 3].my_none?

puts ''; puts "\nmy_count output\:"; puts ''
puts %w[ant bear cat].my_count { |word| word.length }
puts %w[ant bear cat].my_count { |word| word.length >= 4 }
puts [1, 2, 4, 2].count(&:even?)
p range.my_count(&block)
puts [1, 2, 3].my_count(3)