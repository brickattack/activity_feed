require 'leaderboard'

module ActivityFeed
  class Feed
    def initialize(mlg_id)
      @feederboard = Leaderboard.new("mlg:feed_#{mlg_id}", Leaderboard::DEFAULT_OPTIONS, {:redis_connection => ActivityFeed.redis})
    end
    
    def page(page)
      feed_items = []
      @feederboard.leaders(page).each do |feed_item|
        feed_items << ActivityFeed::Item.find(feed_item[:member])    
      end

      feed_items
    end
    
    def total_pages
      @feederboard.total_pages
    end
    
    def total_items
      @feederboard.total_members
    end
  end
end