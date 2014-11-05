class AddParkings < ActiveRecord::Migration
  def change
   create_table :parkings do |t|
    t.string  :kind
    t.float   :hour_price
    t.float   :day_price
    t.integer :places 
   end
  end
end
