class Address < ActiveRecord::Base
  has_one :address

  validates_uniqueness_of :city, :street, :zip_code
  validates :zip_code, format: {with: /\A[0-9]{2}-[0-9]{3}\z/}
end
