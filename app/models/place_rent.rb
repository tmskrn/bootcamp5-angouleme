class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking
  before_save :calc_price

  validates :start_date, :end_date, :parking, :car, presence: true

  scope :ongoing, -> { where("end_date > ?", Time.now)  }

  def finish_rent
    self.end_date = Time.now.utc if end_date.to_date > Time.now.utc
    self.save
  end

  def calc_price
    self.price = days_rate + hours_rate   
  end

  private
  def days_rate
    ((end_date - start_date).to_i / 1.day ) * parking.day_price.to_f 
  end

  def hours_rate
    ((end_date - start_date).to_i % 1.day / 1.hour).to_i * parking.hour_price.to_f
  end

end
