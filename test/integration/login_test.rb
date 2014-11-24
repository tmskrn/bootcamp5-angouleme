require 'test_helper'
require 'capybara/rails'

class LoginTest < ActionDispatch::IntegrationTest
  test 'user successfully logs in' do
    visit 'session/new'
    fill_in('email', with: "mmgumularz@gmail.com")
    fill_in('password', with: "abc123")
    click_button('Sign in')
    assert has_content?("Magdalena")
  end
end
