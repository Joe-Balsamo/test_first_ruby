# # Topics
#
# * Hash
# * Array
# * instance variables
# * regular expressions
#

require 'dictionary'

describe Dictionary do
  before do
    @d = Dictionary.new
  end

  it 'is empty when created' do
    expect(@d.entries).to be == {}
  end

  it 'can add whole entries with keyword and definition' do
    @d.add('fish' => 'aquatic animal')
    expect(@d.entries).to be == {'fish' => 'aquatic animal'}
    expect(@d.keywords).to be == ['fish']
  end

  it 'add keywords (without definition)' do
    @d.add('fish')
    expect(@d.entries).to be == {'fish' => nil}
    expect(@d.keywords).to be == ['fish']
  end

  it 'can check whether a given keyword exists' do
    expect(@d.include?('fish')).to be false
  end

  it "doesn't cheat when checking whether a given keyword exists" do
    expect(@d.include?('fish')).to be false # if the method is empty, this test passes with nil returned
    @d.add('fish')
    expect(@d.include?('fish')).to be true # confirms that it actually checks
    expect(@d.include?('bird')).to be false # confirms not always returning true after add
  end

  it "doesn't include a prefix that wasn't added as a word in and of itself" do
    @d.add('fish')
    expect(@d.include?('fi')).to be false
  end

  it "doesn't find a word in empty dictionary" do
    @d.find('fi').should be_empty # {}
  end

  it 'finds nothing if the prefix matches nothing' do
    @d.add('fiend')
    @d.add('great')
    @d.find('nothing').should be_empty
  end

  it "finds an entry" do
    @d.add('fish' => 'aquatic animal')
    @d.find('fish').should == {'fish' => 'aquatic animal'}
  end

  it 'finds multiple matches from a prefix and returns the entire entry (keyword + definition)' do
    @d.add('fish' => 'aquatic animal')
    @d.add('fiend' => 'wicked person')
    @d.add('great' => 'remarkable')
    @d.find('fi').should == {'fish' => 'aquatic animal', 'fiend' => 'wicked person'}
  end

  it 'lists keywords alphabetically' do
    @d.add('zebra' => 'African land animal with stripes')
    @d.add('fish' => 'aquatic animal')
    @d.add('apple' => 'fruit')
    @d.keywords.should == %w(apple fish zebra)
  end

  it 'can produce printable output like so: [keyword] "definition"' do
    @d.add('zebra' => 'African land animal with stripes')
    @d.add('fish' => 'aquatic animal')
    @d.add('apple' => 'fruit')
    @d.printable.should == %Q{[apple] "fruit"\n[fish] "aquatic animal"\n[zebra] "African land animal with stripes"}
  end
end