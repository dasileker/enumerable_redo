# !/spec/enum_redo_spec.rb

# rubocop : disable Layout/LineLength

require_relative '../enum_redo.rb'

describe Enumerable do
  let(:array1) { ['hi', 34, 'potatoes', 'horses', 33] }
  let(:array2) { [2, 7, 8, 5] }
  let(:empty) { [] }
  let(:nil_array) { [1, 2, nil, 3, 4, 5] }
  let(:false_array) { [nil, nil, false] }
  let(:hash) { { a: 1, b: 2, c: 3, d: 4, e: 5 } }
  let(:arr) { [2, 4, 5] }
  let(:block) { proc { |num| num } }
  let(:my_proc) { proc { |num| num > 10 } }
  let(:range) { (5..10) }

  describe '#my_each' do
    describe 'it should return to Enumerator if there no block' do
      it 'returns an enumerator' do
        expect(array2.my_each).to be_an Enumerator
      end
      it 'should not return to Enumerator if there no block' do
        expect(array1.my_each).to be_an Enumerator
      end
      it 'should not return to Enumerator if there no block' do
        expect(range.my_each).to be_an Enumerator
      end
      it 'should not return to Enumerator if there no block' do
        expect(hash.my_each).to be_an Enumerator
      end
      it 'should not return to Enumerator if there no block' do
        expect(nil_array.my_each).to be_an Enumerator
      end
      it 'should not return to Enumerator if there no block' do
        expect(false_array.my_each).to be_an Enumerator
      end
      it 'should not return to Enumerator if there no block' do
        expect(empty.my_each).to be_an Enumerator
      end
      it 'should not return to false if there no block' do
        expect(empty.my_each).not_to eq(true)
      end
      it 'should not return to true if there no block' do
        expect(empty.my_each).not_to eq(false)
      end
      it 'should not return to truer if there no block' do
        expect(false_array.my_each).not_to eq(false)
      end
      it 'should not return to false if there no block' do
        expect(false_array.my_each).not_to eq(true)
      end
      it 'should not return to false  if there no block' do
        expect(range.my_each).not_to eq(true)
      end
      it 'should not return to true if there no block' do
        expect(range.my_each).not_to eq(false)
      end
    end

    describe ' it should return arrays if there block' do
      it 'iterates through an array and applies block instruction' do
        expect(array2.my_each { |x| empty << x + 1 }).to eq(array2)
      end
      it 'should return empty array if given one' do
        expect([].my_each { |x| empty << x + 1 }).to eq([])
      end
      it 'should return empty array if given one' do
        expect(empty).to eql([])
      end
    end
  end

  describe '#my_each_with_index' do
    context 'it should return to Enumerator if there no block' do
      it 'returns an enumerator' do
        expect(array2.my_each_with_index).to be_an Enumerator
      end
    end

    context 'block' do
      it 'iterates through an array and applies block instruction' do
        expect(array2.my_each_with_index { |x| empty << x + 1 }).to eq(array2)
      end
      it 'should return empty array if given one' do
        expect([].my_each_with_index { |x| empty << x + 1 }).to eq([])
      end
      it 'should return empty array if given one' do
        expect(empty).to eql([])
      end
    end
  end

  describe '#my_select' do
    context 'if no block' do
      it 'should return an Enumerator' do
        expect(array1.my_select).to be_an Enumerator
      end
    end

    context 'if block' do
      it 'returns elements that block returns true' do
        expect(array2.my_select(&:even?)).to eq([2, 8])
      end
      it 'returns an empty array' do
        expect(empty.my_select(&:even?)).to eq(empty)
      end
      it 'returns nil' do
        expect(nil_array.my_select(&:nil?)).to eq([nil])
      end
    end
  end

  describe '#my_all?' do
    context 'it should return nil and true if there is no block' do
      it 'returns true when no elements are false or nil' do
        expect(array2.my_all?).to eql(true)
      end
      it 'it should returns false when any elements are false or nil' do
        expect(nil_array.my_all?).to eq(false)
      end
    end

    describe 'it should return true with block' do
      it 'should returns true for  all' do
        expect(array2.my_all?(&:positive?)).to eq(true)
      end
      it 'should returns true for the item' do
        expect(array2.my_all? { |x| x }).to eq(true)
      end
      it ' it should returns true if the block nil' do
        expect(false_array.my_all? { |x| x == false || x.nil? }).to eq(true)
      end

      it 'it should returns false if element returns false' do
        expect(array2.my_all? { |x| x > 10 }).to eq(false)
      end
      it 'it should returns false if the eleemnt is nil' do
        expect(nil_array.my_all? { |x| x }).to eq(false)
      end
      it 'returns false if the array is small' do
        expect(array2.my_all? { |x| x > 2 }).to eq(false)
      end
      it 'should return true if the array is equal to the value' do
        expect(%w[ant bear cat].any? { |word| word.length >= 4 }).to eq(true)
      end
    end
  end

  describe '#my_any?' do
    it 'should return true for the the length' do
      expect(%w[ant bear cat].any? { |word| word.length >= 3 }).to eq(true)
    end
    it 'should return false if the word is not defined' do
      expect(%w[ant bear cat].any? { |word| word == 'dog' }).to eq(false)
    end
    it 'should return true for the array' do
      expect([1, 2, 3].my_any?).to eq(true)
    end
    it 'should return true for the srting' do
      expect(%w[hi hello hey].my_any?).to eq(true)
    end

    it 'should return false if nil or false' do
      expect([nil, false].my_any?).to eq(false)
    end

    it 'should return false if nil ' do
      expect([nil].my_any?).to eq(false)
    end
    it 'should return false if empty array' do
      expect([].my_any?).to eq(false)
    end
  end

  describe '#my_none?' do
    it 'should return true if the srting array is equal the length' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eq(true)
    end

    it 'should return false if the string not equal to the less or equal than 4' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to eq(false)
    end
    it 'should return false if nil' do
      expect([true, nil].my_none?).to eq(false)
    end
    it 'should return true if empty array' do
      expect([].my_none?).to eq(true)
    end
    it 'should return true if nil' do
      expect([nil].my_none?).to eq(true)
    end
    it 'should return true if nil or false' do
      expect([nil, false].my_none?).to eq(true)
    end
  end

  describe '#my_count' do
    it 'should return the elements in array' do
      expect(array2.my_count).not_to eq(5)
    end
    it 'should return the elements equal to 3 in array' do
      expect([1, 2, 3].my_count(3)).to eq(1)
    end
    it 'should return the elements in  equal to 0 array' do
      expect(empty.my_count(3)).to eq(0)
    end
    it 'should return the elements in array' do
      expect(false_array.my_count(nil)).to eq(2)
    end
    it 'returns number of elements yielding a true value' do
      expect(array2.my_count(&:even?)).to eq(2)
    end
    it 'returns number of elements yielding a true value' do
      expect(array2.my_count { |x| x.eql? 10 }).to eq(0)
    end
    it 'returns number of elements yielding a true value' do
      expect(false_array.my_count { |x| x.eql? nil }).to eq(2)
    end
  end

  describe '#my_map' do
    it 'should get multiply the range' do
      expect((1..4).my_map { |i| i * i }).to eq([1, 4, 9, 16])
    end
    it 'should return cat cat cat' do
      expect((1..4).my_map { 'cat' }).to eq(%w[cat cat cat cat])
    end
    it 'should return multiplication for [1, 2, 3, 4]' do
      expect((1..4).my_map(&block)).to eq([1, 2, 3, 4])
    end
    it 'should get true and false' do
      expect((1..10).my_map { |i| i >= 3 && i <= 7 }).to eq([false, false, true, true, true, true, true, false, false, false])
    end
  end

  describe '#my_inject' do
    it 'combines all elements by applying block instructions' do
      expect(array2.my_inject { |sum, x| sum + x }).to eq(22)
    end
    it 'it returns all instructions for my_inject' do
      expect(array2.my_inject { |product, x| product * x }).to eql(0)
    end
    it 'combines all elements by applying block instructions to initial value ' do
      expect(array2.my_inject(2) { |sum, x| sum + x }).to eq(24)
    end
    it 'it should return the sum for my_inject' do
      expect(array2.my_inject(0) { |sum, x| sum + x }).to eq(22)
    end
    it 'it should return the multiply for  my_inject' do
      expect(array2.my_inject(2) { |product, x| product * x }).to eq(1120)
    end
  end

  describe '#multiply_els' do
    it 'it should return the multiply from the inject' do
      expect(arr.inject(:*)).to eq(40)
    end
  end
end

# rubocop : enable Layout/LineLength
