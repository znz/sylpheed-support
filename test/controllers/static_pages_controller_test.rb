require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select 'title', I18n.t(:'nav.site_name')
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select 'title', full_title(I18n.t(:'nav.about'))
  end

end
