class AddCardClassToTags < ActiveRecord::Migration
  def change
    add_column :tags, :card_class, :string
  end
end
