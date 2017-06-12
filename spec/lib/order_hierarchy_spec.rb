require 'spec_helper'

describe OrderHierarchy do

  class TempClass
    include OrderHierarchy

    attr_reader :children
  end

  let(:dummy_obj) { TempClass.new }

  describe ".add_child" do
    it "should add a child object" do
      expect(dummy_obj.children).to be_nil
      dummy_obj.add_child('Adding a string')
      expect(dummy_obj.children.size).to eq(1)
    end

    it "does not add nil" do
      expect(dummy_obj.children).to be_nil
      dummy_obj.add_child(nil)
      expect(dummy_obj.children).to be_nil
    end
  end

  describe ".concat_children" do
    it "should concatenate child objects" do
      dummy_obj.add_child('Adding a string')
      expect(dummy_obj.children.size).to eq(1)
      dummy_obj.concat_children(['Adding another string', 'Adding yet another string'])
      expect(dummy_obj.children.size).to eq(3)
    end

    it "does not concatenate nil" do
      dummy_obj.add_child('Adding a string')
      expect(dummy_obj.children.size).to eq(1)
      dummy_obj.concat_children(nil)
      expect(dummy_obj.children.size).to eq(1)
    end
  end

  describe ".total_price" do
    it "returns the sums of all the children" do
      dummy_obj.concat_children([1,2,3,4,5])
      expect(dummy_obj.total_price).to eq(15)
    end

    it "returns the sums of all the children if there is only 1" do
      dummy_obj.add_child(BundleLine.new(3, Bundle.new(3, 5)))
      expect(dummy_obj.total_price).to eq(15)
    end

    it "returns 0 if there is no children" do
      expect(dummy_obj.total_price).to eq(0)
    end
  end
end