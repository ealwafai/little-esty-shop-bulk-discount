class Merchant < ApplicationRecord
  has_many :items, :dependent => :destroy

  def self.enabled
    where(status: 'enabled')
  end

  def self.disabled
    where(status: 'disabled')
  end
end
