$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')
require 'algorithms'
  
shared_examples "empty splaytree" do
  it "should let you push stuff in" do
    100.times { |x| @tree[x] = x }
    @tree.size.should eql(100)
  end
  
  it "should return 0 for size" do
    @tree.size.should eql(0)
  end
  
  it "should return nil for #min and #max" do
    @tree.min.should be_nil
    @tree.max.should be_nil
  end
  
  it "should return nil for #delete" do
    @tree.delete(:non_existing).should be_nil
  end
  
  it "should return nil for #get" do
    @tree[4235].should be_nil
  end
end

shared_examples "non-empty splaytree" do
  before(:each) do
    @num_items = 100
    @random_array = []
    @num_items.times { @random_array << rand(@num_items) }
    @random_array.each { |x| @tree[x] = x }
  end
  
  it "should return correct size (uniqify items first)" do
    @tree.size.should eql(@random_array.uniq.size)
  end
  
  it "should have correct height (worst case is when items are inserted in order, and height = num items inserted)" do
    @tree.clear
    10.times { |x| @tree[x] = x }
    @tree.height.should eql(10)
  end
  
  it "should return correct max and min keys" do
    @tree.min[0].should eql(@random_array.min)
    @tree.max[0].should eql(@random_array.max)
  end
  
  it "should not #has_key? keys it doesn't have" do
    @tree.has_key?(10000).should be_false
  end
  
  it "should #has_key? keys it does have" do
    @tree.has_key?(@random_array[0]).should be_true
  end
  
  it "should remove any key" do
    random_key = @random_array[rand(@num_items)]
    @tree.has_key?(random_key).should be_true
    @tree.delete(random_key).should eql(random_key)
    @tree.has_key?(random_key).should be_false
  end
  
  it "should let you iterate with #each" do
    counter = 0
    sorted_array = @random_array.uniq.sort
    @tree.each do |key, val|
      key.should eql(sorted_array[counter])
      counter += 1
    end
  end
end

describe "empty splaytreemap" do
  before(:each) do
    @tree = Containers::RubySplayTreeMap.new
  end
  it_should_behave_like "empty splaytree"
end

describe "full splaytreemap" do
  before(:each) do
    @tree = Containers::RubySplayTreeMap.new
  end
  it_should_behave_like "non-empty splaytree"
end

begin
  Containers::CSplayTreeMap
  describe "empty csplaytreemap" do
    before(:each) do
      @tree = Containers::CSplayTreeMap.new
    end
    it_should_behave_like "empty splaytree"
  end

  describe "full csplaytreemap" do
    before(:each) do
      @tree = Containers::CSplayTreeMap.new
    end
    it_should_behave_like "non-empty splaytree"
  end
rescue Exception
end
