class Question < ActiveRecord::Base
  is_impressionable
  acts_as_votable

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :finders, :history]

  belongs_to :user
  has_many :tags
  has_many :answers, :dependent => :destroy

  validates :title, :presence => true
  validates :body, :presence => true

end
