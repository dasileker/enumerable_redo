# !/spec/enum_redo_spec.rb

require './enum_redo.rb'

describe Enumerable do
  
  let(:array1) {['hi', 34, 'potatoes', 'horses', 33]}
  let(:array2) {[2, 7, 8, 5]}
  let(:empty) {[]}
  let(:nil_array) {[1, 2, nil, 3, 4, 5]}
  let(:false_array) {[nil, nil, false]}
  let(:hash) {{ a: 1, b: 2, c: 3, d: 4, e: 5 }}
  let(:block) {proc { |num| num }}
  let(:my_proc) {proc { |num| num > 10 }}
  let(:range) {(5..10)}

  describe "#my_each" do
    
    context 'no block' do
      it 'returns an enumerator' do
        expect(array2.my_each).to be_an Enumerator
      end
    end

    context " block" do
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

  describe "#my_each_with_index" do
    
    context 'no block' do
      it 'returns an enumerator' do
        expect(array2.my_each_with_index).to be_an Enumerator
      end
    end

    context " block" do
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
    
    context "if no block" do
      it 'should return an Enumerator' do
        expect(array1.my_select).to be_an Enumerator
      end
    end

    context "if block" do
      it 'returns elements that block returns true' do
        expect(array2.my_select { |x| x.even? }).to eq([2, 8])
      end
      it 'returns an empty array' do
        expect(empty.my_select { |x| x.even? }).to eq(empty)
      end
      it 'returns nil' do
        expect(nil_array.my_select { |x| x.nil? }).to eq([nil])
      end
    end
  end

  describe '#my_all?' do
    context "without block" do
      it "returns true when no elements are false or nil" do
        expect(array2.my_all?).to eql(true)
      end
      it "returns false when any elements are false or nil" do
        expect(nil_array.my_all?).to eq(false)
      end
    end

    describe ' with block' do
      it 'should returns true for  all' do
        expect(array2.my_all? { |x| x > 0 }).to eq(true)
      end
      it 'should returns true' do
        expect(array2.my_all? { |x| x }).to eq(true)
      end
      it 'should returns true' do
        expect(false_array.my_all? { |x| x == false || x == nil }).to eq(true)
      end

      it 'returns false if element returns false' do
        expect(array2.my_all? { |x| x > 10 }).to eq(false)
      end
      it 'returns false ' do
        expect(nil_array.my_all? { |x| x }).to eq(false)
      end
      it 'returns false ' do
        expect(array2.my_all? { |x| x > 2 }).to eq(false)
      end
    end
  end


end