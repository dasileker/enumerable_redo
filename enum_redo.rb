# rubocop : disable  Metrics/ModuleLength, Layout/EmptyLinesAroundModuleBody, Layout/EmptyLineAfterGuardClause,  Layout/EmptyLines,  Metrics/CyclomaticComplexity, Metrics/MethodLength, Layout/IndentationConsistency, Style/For, Layout/IndentationWidth, Style/NumericPredicate, Style/IfInsideElse, Style/InverseMethods, Style/IdenticalConditionalBranches, Metrics/PerceivedComplexity


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

  def my_all?
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

  def my_any?
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

  def my_map(proc = nil, &block)
    result = []

    for i in self
      result << block.call(proc.call(i)) if proc and block_given?
      result << proc.call(i) unless block_given?
      result << yield(i) if !proc and block_given?
    end
    result
  end

  # def my_inject(symbol = nil, initial_value = nil)
  #   if symbol.class != Symbol
  #     temp = symbol
  #     symbol = initial_value
  #     initial_value = temp
  #   end
  #   value_provided = false
  #   value_provided = true unless initial_value.nil?
  #   memo = initial_value || first
  #   case symbol
  #   when :+
  #     if !value_provided
  #       drop(1).my_each do |n|
  #         memo += n
  #       end
  #     else
  #       my_each do |n|
  #         memo += n
  #       end
  #     end
  #   when :*
  #     if !value_provided
  #       drop(1).my_each do |n|
  #         memo *= n
  #       end
  #     else
  #       my_each do |n|
  #         memo *= n
  #       end
  #     end
  #   when :/
  #     if !value_provided
  #       drop(1).my_each do |n|
  #         memo /= n
  #       end
  #     else
  #       my_each do |n|
  #         memo /= n
  #       end
  #     end
  #   when :-
  #     if !value_provided
  #       drop(1).my_each do |n|
  #         memo -= n
  #       end
  #     else
  #       my_each do |n|
  #         memo -= n
  #       end
  #     end
  #   when :**
  #     if !value_provided
  #       drop(1).my_each do |n|
  #         memo **= n
  #       end
  #     else
  #       my_each do |n|
  #         memo **= n
  #       end
  #     end
  #   else
  #     if !value_provided
  #       drop(1).my_each do |n|
  #         memo = yield(memo, n)
  #       end
  #     else
  #       my_each do |n|
  #         memo = yield(memo, n)
  #       end
  #     end
  #   end
  #   memo
  # end

  def my_inject(result = 0, symbol = nil)
    symbol, result = result, symbol if result.is_a?(Symbol) and symbol.is_a?(Integer)
    symbol, result = result, 0 if result.is_a?(Symbol)
    new_array = to_a
    result = '' if new_array[0].is_a?(String)
    if !block_given?
      case symbol
      when :+
        new_array.length.times { |n| result += new_array[n] }
      when :*
        new_array.length.times { |n| result *= new_array[n] }
      when :/
        new_array.length.times { |n| result /= new_array[n] }
      when :-
        new_array.length.times { |n| result -= new_array[n] }
      when :**
        new_array.length.times { |n| result **= new_array[n] }
      when :%
        new_array.length.times { |n| result %= new_array[n] }
      end
      result
    else
      new_array.length.times { |n| result = yield(result, new_array[n]) }
    end
    result
  end
end

  def multiply_els(arr)
  arr.my_inject { |x, y| x * y }
  end



# rubocop : enable  Metrics/ModuleLength, Layout/EmptyLinesAroundModuleBody, Layout/EmptyLineAfterGuardClause,  Layout/EmptyLines,  Metrics/CyclomaticComplexity, Metrics/MethodLength, Layout/IndentationConsistency, Style/For, Layout/IndentationWidth, Style/NumericPredicate, Style/IfInsideElse, Style/InverseMethods, Style/IdenticalConditionalBranches, Metrics/PerceivedComplexity
