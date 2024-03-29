require 'role_model'
class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :user_name, :use => [:slugged, :finders, :history]

  has_merit

  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers

  validates :first_name, :presence => true

  include RoleModel

  # optionally set the integer attribute to store the roles in,
  # :roles_mask is the default
  roles_attribute :roles_mask

  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :admin, :editor, :guest

  # User Profile Pictures
  has_attached_file :avatar, :styles => { :default => "100x100>", :avatar => "32x32>"},
                    :content_type => { :content_type => "image/jpg, image/png, image/jpeg" },
                    :default_url => "https://s3.amazonaws.com/hearthstonia/App-Design/user-profile/default_picture.png"

  # has_attached_file :cover, :styles => { :default => "750x100#"}

end
