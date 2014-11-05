class Person < ActiveRecord::Base
  has_many :parkings, foreign_key: :owner_id
  has_many :cars, foreign_key: :owner_id

  validates_presence_of :first_name
end
