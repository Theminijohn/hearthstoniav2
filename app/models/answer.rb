class Answer < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  belongs_to :question

  validates :body, :presence => true, length: { minimum: 15 }
  validates :question_id, :presence => true
  validates :user_id, :presence => true
end
