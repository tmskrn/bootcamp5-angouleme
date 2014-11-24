require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "authentication method" do
    account = Account.create(email: "abc@abc.com", password: "abc123")

    assert_equal account, Account.authenticate("abc@abc.com", "abc123")
    assert_equal nil, Account.authenticate("abc@abc.com", "asdf")
  end
end
