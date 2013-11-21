class AddSpecsToTags < ActiveRecord::Migration
  def change
    add_column :tags, :card_cost, :integer
    add_column :tags, :card_attack, :integer
    add_column :tags, :card_health, :integer
  end
end
