class Question < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => [:slugged, :finders, :history]

  belongs_to :user
  has_many :tags
end
