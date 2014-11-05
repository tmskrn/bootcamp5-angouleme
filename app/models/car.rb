class Car < ActiveRecord::Base
  belongs_to :owner, class_name: "Person"
  has_many :place_rents

  validates :owner, :model, :registration_number, presence: true
end
