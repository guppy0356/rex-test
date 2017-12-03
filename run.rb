require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.register_driver(:headless_chrome) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu] }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.javascript_driver = :headless_chrome
Capybara.default_driver = :headless_chrome

class HeadlessChrome
  include Capybara::DSL
  def capture
    visit 'https://rex.libertyfish.co.jp/'
    page.save_screenshot 'screenshot.png'
  end
end

chrome = HeadlessChrome.new
chrome.capture
