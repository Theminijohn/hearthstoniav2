class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders, :history]

  belongs_to :question
end
