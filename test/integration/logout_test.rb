require 'test_helper'
require 'capybara/rails'

class LogoutTest < ActionDispatch::IntegrationTest
  def setup
    visit 'session/new'
    fill_in('email', with: "mmgumularz@gmail.com")
    click_button('Sign in')
    assert page.has_content?("Magdalena") 
  end

  test 'user logs out' do
    visit '/cars'
    #save_and_open_page
    click_link('log out')
    assert_equal current_url, root_url
    assert page.has_no_content?('Magdalena')
    assert page.has_content?('You have logged out') 
  end
end
