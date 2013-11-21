class AddCardTypeToTags < ActiveRecord::Migration
  def change
    add_column :tags, :card_type, :string
  end
end
