class Merchant < ApplicationRecord
  has_many :items, :dependent => :destroy

  def self.enabled
    where(status: 'enabled')
  end

  def self.disabled
    where(status: 'disabled')
  end

  def items_enabled
    items.status_enabled
  end

  def items_disabled
    items.status_disabled
  end

  def most_popular_items
    items.popular_items
  end

  def items_top_day_revenue(item_id)
    items.item_top_day(item_id)
  end
end
