class Parking < ActiveRecord::Base
  belongs_to :address
  belongs_to :owner, class_name: "Person"
  has_many :cars, through: :place_rents
  has_many :place_rents
  before_destroy :finish_all_place_rents


  validates :places, presence: true
  validates :hour_price, presence: true, numericality: true
  validates :day_price,  presence: true, numericality: true
  validates :kind, inclusion: {in: %w(outdoor indoor private street)}

  accepts_nested_attributes_for :address

  scope :private_parkings, -> { where(kind: "private") }
  scope :public_parkings, -> { where.not(kind: "private")}
  scope :within_day_price_range, -> (min, max) { where("day_price between ? and ?", min, max )}
  scope :within_hour_price_range, -> (min, max) { where("hour_price between ? and ?", min, max )}
  scope :city_parkings, -> (city) { joins(:address).where("city = ?", city)  }

  def city
    self.address.city
  end

  private
  def finish_all_place_rents
    self.place_rents.ongoing.each do |place_rent|
      place_rent.finish_rent
    end
  end

end
