class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def short_date
    strftime('%m/%d/%y')
  end
end
