require "application_system_test_case"

class UrlsTest < ApplicationSystemTestCase
  test "Visit the create short url page" do
    visit root_url
    page.has_selector? '#url_long_url'
    page.has_button? 'Create Short URL'
  end

  test 'create short url' do
    visit root_url

    fill_in 'url_long_url', with: 'https://www.apple.com'
    click_on 'Create Short URL'

    assert_text "Your shortened URL"
    assert_text "short.url/"
  end

  test "track clicks for short url" do
    @url = Url.new
    @url.long_url = "https://www.amazon.com"
    @url.save

    visit url_url(@url)

    dashboard_view = window_opened_by { click_link "the total clicks" }

    within_window dashboard_view do
      assert_equal find('#total_clicks').text, "0"
      dashboard_view.close
    end

    3.times {
      click_on "#{@url.short_url}"
    }

    dashboard_view = window_opened_by { click_link "the total clicks" }

    within_window dashboard_view do
      assert_equal find('#total_clicks').text, "3"
      dashboard_view.close
    end
  end

  test "clicking short url redirects to long url" do
    @url = Url.new
    @url.long_url = "https://www.apple.com"
    @url.save

    visit url_url(@url)

    redirect_page = window_opened_by { click_link "#{@url.short_url}" }

    within_window redirect_page do
      assert_equal page.current_url, "https://www.apple.com/"
      assert_equal page.title, "Apple"
      redirect_page.close
    end
  end
end
