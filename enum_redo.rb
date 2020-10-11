# rubocop : disable  Metrics/ModuleLength, Layout/EmptyLinesAroundModuleBody, Layout/EmptyLineAfterGuardClause,  Layout/EmptyLines,  Lint/ParenthesesAsGroupedExpression, Lint/AmbiguousBlockAssociation, Style/Semicolon, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Layout/IndentationConsistency, Style/For, Layout/IndentationWidth, Style/NumericPredicate, Style/IfInsideElse, Style/InverseMethods, Style/IdenticalConditionalBranches, Style/MixinUsage,  Lint/UselessAssignment, Metrics/PerceivedComplexity


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
    my_each { |i| result << i if yield(i) }
    result
  end

  def my_all? ##
    cnt_true = 0
    for i in self
      if block_given?
        cnt_true += 1 unless yield(i)
      else
        cnt_true += 1 unless i
      end
    end
    cnt_true == 0
  end

  def my_any? ##
    any = 0

    for i in self
      if block_given?
        any += 1 if yield(i)
      else
        any += 1 if i != false and !i.nil?
      end
    end
    !(any == 0)
  end

  def my_none?
    if block_given?
      my_each do |i|
        return false if yield(i)
      end
      true
    else
      my_each do |i|
        return false if i != false && !i.nil?
      end
      true
    end
  end

  def my_count(number = true)
    my_count = 0
    if block_given?
      my_each do |i|
        my_count += 1 if yield(i)
      end
      my_count
    else
      my_each do |i|
        my_count += 1 if i == number
      end
      if number == 0
        length
      else
        my_count
      end
    end
  end

  def my_map(proc = nil, &block) ##
    result = []

    for i in self
      result << block.call(proc.call(i)) if proc and block_given?
      result << proc.call(i) unless block_given?
      result << yield(i) if !proc and block_given?
    end
    result
  end

  def my_inject(symbol = nil, initial_value = nil)
    if symbol.class != Symbol
      temp = symbol
      symbol = initial_value
      initial_value = temp
    end
    value_provided = false
    value_provided = true unless initial_value.nil?
    memo = initial_value || first
    case symbol
    when :+
      if !value_provided
        drop(1).my_each do |n|
          memo += n
        end
      else
        my_each do |n|
          memo += n
        end
      end
    when :*
      if !value_provided
        drop(1).my_each do |n|
          memo *= n
        end
      else
        my_each do |n|
          memo *= n
        end
      end
    when :/
      if !value_provided
        drop(1).my_each do |n|
          memo /= n
        end
      else
        my_each do |n|
          memo /= n
        end
      end
    when :-
      if !value_provided
        drop(1).my_each do |n|
          memo -= n
        end
      else
        my_each do |n|
          memo -= n
        end
      end
    when :**
      if !value_provided
        drop(1).my_each do |n|
          memo **= n
        end
      else
        my_each do |n|
          memo **= n
        end
      end
    else
      if !value_provided
        drop(1).my_each do |n|
          memo = yield(memo, n)
        end
      else
        my_each do |n|
          memo = yield(memo, n)
        end
      end
    end
    memo
  end

  def multiply_els(arr)
    arr.my_inject do |memo, n|
      memo * n
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


puts "\nmy_each output\:"; puts ''
array1.my_each { |item| puts item }
p array2.each { |item| puts item }
p array2.my_each(&block)
range.my_each { |item| puts item }
p range.my_each(&block)
(hash.my_each { |item, index| puts "#{item} : #{index} " })
p hash.my_each(&block)

puts "\nmy_each_with_index output\:"; puts ''
array1.my_each_with_index { |item, index| puts "#{item} : #{index} " }
p array2.my_each_with_index { |item, index| "#{item} : #{index} " }
p array2.my_each_with_index(&block)
range.my_each_with_index { |item| puts item }
p range.my_each_with_index(&block)
hash.my_each_with_index { |item, index| puts "#{item} : #{index} " }

puts "\nmy_select output\:"; puts ''
puts array1.my_select { |item| item.to_s.length > 2 }
p array2.my_select { |item| item }
range.my_select { |item| puts item }

puts ''; puts "\nmy_all? output\:"; puts ''
puts (%w[lul what potatoes uhh].my_all? { |word| word.length >= 3 })
puts ['lul', 'what', 'potatoes', 'uhh', nil].my_all?
puts [1, 2, 3].my_all?
puts %w[hi hello hey].my_all?
p [1, false, 'hi', []].my_all?
puts [3, 3, 3].my_all?

puts ''; puts "\nmy_any? output\:"; puts ''
puts %w[ant bear cat].my_any? { |word| word.length >= 3 }
puts %w[ant bear cat].my_any? { |word| word.length >= 4 }
puts range.my_any?
puts [].my_any?
puts [nil].my_any?
puts [nil, false].my_any?
puts [1, 2, 3].my_any?
puts %w[hi hello hey].my_any?
puts [3, 3, 3].my_any?

puts ''; puts "\nmy_none? output\:"; puts ''
puts %w[ant bear cat].my_none? { |word| word.length == 5 }
puts %w[ant bear cat].my_none? { |word| word.length >= 4 }
puts range.my_none?
puts [].my_none?
puts [nil].my_none?
puts [nil, false].my_none?
p [1, 2, 3].my_none?
p [nil, false, nil, false].my_none?
puts %w[hi hello hey].my_none? # false
puts [3, 3, 3].my_none?

puts ''; puts "\nmy_count output\:"; puts ''
puts %w[ant bear cat].my_count(&:length)
puts %w[ant bear cat].my_count { |word| word.length >= 4 }
puts [1, 2, 4, 2].count(&:even?)
p range.my_count(&block)
puts [1, 2, 3].my_count(3)


my_proc = proc { |i| i * i }

puts ''; puts "\nmy_map output\:"; puts ''
p (1..4).my_map { |i| i * i }
p (1..4).my_map { 'cat' }
p (1..4).my_map(&my_proc)
array2.my_map(my_proc) { |num| num < 10 }

longest = %w[cat sheep bear].my_inject do |memo, word|
  memo.length > word.length ? memo : word
end

puts "\nmy_inject output\:"; puts ''
puts (5..10).my_inject { |sum, n| sum + n }
puts (5..10).my_inject { |product, n| product * n }
puts [1, 2, 3].my_inject(20, :*)
puts longest


puts "\nmultiply_els output\: " + multiply_els([2, 4, 5]).to_s
puts

# rubocop : enable  Metrics/ModuleLength, Layout/EmptyLinesAroundModuleBody, Layout/EmptyLineAfterGuardClause,  Layout/EmptyLines,  Lint/ParenthesesAsGroupedExpression, Lint/AmbiguousBlockAssociation, Style/Semicolon, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Layout/IndentationConsistency, Style/For, Layout/IndentationWidth, Style/NumericPredicate, Style/IfInsideElse, Style/InverseMethods, Style/IdenticalConditionalBranches, Style/MixinUsage,  Lint/UselessAssignment, Metrics/PerceivedComplexity
