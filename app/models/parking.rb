class Parking < ActiveRecord::Base
  belongs_to :address
  belongs_to :owner, class_name: "Person"
  has_many :cars, through: :place_rents
  has_many :place_rents

  validates :places, presence: true
  validates :hour_price, presence: true, numericality: true
  validates :day_price,  presence: true, numericality: true
  validates :kind, inclusion: {in: %w(outdoor indoor private or street)}

  accepts_nested_attributes_for :address
end
