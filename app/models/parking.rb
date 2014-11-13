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

  def self.search(params)
    parkings = Parking.all
    parkings = params[:city_parkings].blank? ? parkings : parkings.city_parkings(params[:city_parkings])
    if params[:day_price_from].present? && params[:day_price_to].present?
     parkings = parkings.within_day_price_range(params[:day_price_from], params[:day_price_to])
    end

    if params[:hour_price_from].present? && params[:hour_price_to].present?
      parkings = parkings.within_hour_price_range(params[:hour_price_from], params[:hour_price_to])
    end

    if params[:private_parking] == "1" && params[:public_parking].nil?
      parkings = parkings.private_parkings
    elsif params[:private_parking].nil? and params[:public_parking] == "1"
      parkings = parkings.public_parkings
    end
    parkings
  end

  private
  def finish_all_place_rents
    self.place_rents.ongoing.each do |place_rent|
      place_rent.finish_rent
    end
  end
end
