require 'test_helper'
require 'capybara/rails'

class LoginTest < ActionDispatch::IntegrationTest
  test 'user successfully logs in' do
    visit 'session/new'
    fill_in('email', with: "mmgumularz@gmail.com")
    click_button('Sign in')
    assert page.has_content?("Magdalena")
  end
end
