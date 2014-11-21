class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email
      t.references :person, index: true

      t.timestamps
    end
  end
end
