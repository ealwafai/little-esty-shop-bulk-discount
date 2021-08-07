class UpdatePercentage < ActiveRecord::Migration[5.2]
  def change
    remove_column :bulk_discounts, :percentage, :decimal
    add_column :bulk_discounts, :percentage, :integer
  end
end
