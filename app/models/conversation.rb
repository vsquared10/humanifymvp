class Conversation < ActiveRecord::Base
  has_many :participates, through: :users
  belongs_to :user
end
