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

puts "\nmy_each_with_index output\:"; puts ''
array1.my_each_with_index { |item, index| puts "#{item} : #{index} " }
p array2.my_each_with_index { |item, index| "#{item} : #{index} " }
p array2.my_each_with_index(&block)
range.my_each_with_index { |item| puts item }
p range.my_each_with_index(&block)
hash.my_each_with_index { |item, index| puts "#{item} : #{index} " }