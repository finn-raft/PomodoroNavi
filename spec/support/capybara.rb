Selenium::WebDriver::Chrome::Service.driver_path = '/usr/local/bin/chromedriver' if File.exist?('/usr/local/bin/chromedriver')

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')

  # 追加: Chromeのパスを明示的に指定
  options.binary = '/usr/bin/google-chrome' if File.exist?('/usr/bin/google-chrome')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end