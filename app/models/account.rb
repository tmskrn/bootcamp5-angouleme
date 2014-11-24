class Account < ActiveRecord::Base
  belongs_to :person
  has_secure_password

  def self.authenticate(email, password)
    account = Account.find_by_email(email)
    account.authenticate(password) ? account : nil 
  end
end
