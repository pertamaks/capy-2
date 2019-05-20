require 'capybara/cucumber'
require 'selenium-webdriver'
require 'capybara/session'
require 'capybara/dsl'
require 'capybara-screenshot/cucumber'
require 'pry'

module Browser
  # handler
  @browser = :firefox
  Capybara.default_driver = @browser
  # Capybara.javascript_driver = :headless_chrome
  Capybara.default_max_wait_time = 5
  Capybara::Screenshot.autosave_on_failure = false
  Capybara.save_path = 'E:\\GIT AUTO\\capy 2\\screenshot'
  Capybara.exact = true
  Capybara.match = :prefer_exact

  # handler set-up

  # Driver Chrome
  opt_chrome = Selenium::WebDriver::Chrome::Options.new
  opt_chrome.add_preference(:download, prompt_for_download: false, default_directory: '/tmp/downloads',)
  opt_chrome.add_argument('--window-size=1024,700')

  opt_chrome.add_preference(:browser, set_download_behavior: { behavior: 'allow' })

  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: opt_chrome)
  end

  # Driver Firefox
  opt_fox = Selenium::WebDriver::Firefox::Options.new
  # opt_fox.add_preference(:download, prompt_for_download: false, default_directory: '/tmp/downloads', marionette: true)
  # opt_fox.add_preference(:browser, set_download_behavior: { behavior: 'allow' })
  opt_fox.add_argument('--width=1024')
  opt_fox.add_argument('--height=700')

  Capybara.register_driver :firefox do |app|
    Capybara::Selenium::Driver.new(app, browser: :firefox, options: opt_fox)
  end

  # Driver Headless_Chrome
  Capybara.register_driver :headless_chrome do |app|
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument('--window-size=1280,800')

    driver = Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)

    ### Allow file downloads in Google Chrome when headless!!!
    ### https://bugs.chromium.org/p/chromium/issues/detail?id=696481#c89
    bridge = driver.browser.send(:bridge)

    path = '/session/:session_id/chromium/send_command'
    path[':session_id'] = bridge.session_id

    bridge.http.call(:post, path, cmd: 'Page.setDownloadBehavior', params: { behavior: 'allow', downloadPath: '/tmp/downloads' })
    ###
    
    driver
  end
end

# The driver name should match the Capybara driver config name.
Capybara::Screenshot.register_driver(@browser) do |driver, path|
  driver.browser.save_screenshot path
end

#
# Selenium grid set up
# remote browser
#
capabilities = Selenium::WebDriver::Remote::Capabilities.new
capabilities['browserName'] = 'firefox'
capabilities['version'] = ''
capabilities['platform'] = 'WINDOWS'
capabilities['cssSelectorsEnabled'] = true
capabilities['javascriptEnabled'] = true

Capybara.register_driver :remote_fox do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 1200 # seconds

  Capybara::Selenium::Driver.new(app, http_client: client, browser: :remote, url: 'http://172.19.16.134:4444/wd/hub', desired_capabilities: capabilities)
end
