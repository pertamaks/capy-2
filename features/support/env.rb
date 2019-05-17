require 'capybara/cucumber'
require 'selenium-webdriver'
require 'capybara/session'
require 'capybara/dsl'
require 'capybara-screenshot/cucumber'
require 'pry'

# handler
Capybara.default_driver = :chrome
Capybara.javascript_driver = :headless_chrome
Capybara.default_max_wait_time = 5
Capybara.save_path = 'E:\\GIT AUTO\\capy 2\\screenshot'
Capybara.exact = true
Capybara.match = :prefer_exact

# handler set-up
options = Selenium::WebDriver::Chrome::Options.new
options.add_preference(:download, prompt_for_download: false,
                                  default_directory: '/tmp/downloads')

options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

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

  bridge.http.call(:post, path, cmd: 'Page.setDownloadBehavior',
                                params: {
                                  behavior: 'allow',
                                  downloadPath: '/tmp/downloads'
                                })
  ###

  driver
end

# The driver name should match the Capybara driver config name.
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot path
end

#
# Selenium grid set up
# remote browser
#
capabilities = Selenium::WebDriver::Remote::Capabilities.new
capabilities['browserName'] = 'firefox'
capabilities['version'] = ''
# capabilities['platform'] = “Linux”
capabilities['video'] = 'True'

Capybara.register_driver :remote_fox do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 1200 # seconds

  Capybara::Selenium::Driver.new(app, http_client: client,
                                      browser: :remote,
                                      url: 'http://localhost:4444/wd/hub',
                                      desired_capabilities: capabilities)
end
