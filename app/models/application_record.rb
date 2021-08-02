class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.status_enabled
    where(status: 'enabled')
  end

  def self.status_disabled
    where(status: 'disabled')
  end

  def short_date
    strftime('%m/%d/%y')
  end
end
