class PlaceRent < ActiveRecord::Base
  belongs_to :car
  belongs_to :parking
  before_save :calc_price

  validates :start_date, :end_date, :parking, :car, presence: true

  def finish_rent
    self.end_date = Time.now if end_date > Time.now
  end

  def calc_price
    #self.price = 2
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
