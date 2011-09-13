require 'spec_helper'

describe ActivityFeed::Item do
  it 'should allow you to create a new Item' do
    item = Fabricate.build(ActivityFeed::Item)
    item.save.should be_true
  end
  
  it 'should allow for a large amount of text' do
    item = Fabricate.build(ActivityFeed::Item, :text => '*' * 8192)
    item.text.should eql('*' * 8192)
  end
  
  it 'should add the feed item ID to redis' do
    item = Fabricate.build(ActivityFeed::Item)
          
    ActivityFeed.redis.zcard("mlg:feed_#{item.mlg_id}").should be(0)
    item.save
    ActivityFeed.redis.zcard("mlg:feed_#{item.mlg_id}").should be(1)      
  end  
end