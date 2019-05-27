require 'capybara/cucumber'
require 'selenium-webdriver'
require 'capybara/session'
require 'capybara/dsl'
require 'capybara-screenshot/cucumber'
require 'pry'

module Browser
  # Untuk setup default evironment testing, dan segala addonnya

  # code dibawah ini adalah untuk setup Capybara waiting time, dengan value default adalah 2 detik
  Capybara.default_max_wait_time = 5 #detik

  # code dibawah ini adalah untuk disable auto save feature pada gem Capybara-Screenshot
  # Capybara::Screenshot.autosave_on_failure = false

  # code dibawah ini untuk defining selector pada Capybara
  Capybara.exact = true
  Capybara.match = :prefer_exact
  
  # code dibawh ini adalah Set up driver untuk Chrome
  opt_chrome = Selenium::WebDriver::Chrome::Options.new
  opt_chrome.add_preference(:download, prompt_for_download: false, default_directory: '/tmp/downloads')
  # opt_chrome.add_argument('--window-size=1024,700') # kalau mau set window size tanpa menggunakan hooks

  opt_chrome.add_preference(:browser, set_download_behavior: { behavior: 'allow' })

  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: opt_chrome)
  end

  # code dibawah ini adalah Set up driver untuk Firefox
  opt_fox = Selenium::WebDriver::Firefox::Options.new
  # opt_fox.add_argument('--width=1024') # to set window size without hooks
  # opt_fox.add_argument('--height=700') # to set window size without hooks

  Capybara.register_driver :firefox do |app|
    Capybara::Selenium::Driver.new(app, browser: :firefox, options: opt_fox)
  end

  # code dibawah ini adalah Set up driver untuk Headless_Chrome
  # headless adalah driver tanpa UI, namun tidak semua website dapat ditest menggunakan headless driver
  Capybara.register_driver :headless_chrome do |app|
    opt_headchrome = Selenium::WebDriver::Chrome::Options.new
    opt_headchrome.add_argument('--headless')
    opt_headchrome.add_argument('--disable-gpu')
    # opt_headchrome.add_argument('--window-size=1024,700') # to set window size without hooks

    driver = Capybara::Selenium::Driver.new(app, browser: :chrome, options: opt_headchrome)

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

module Remote_browser
  # Selenium grid set up
  # code dibawah ini adalah set up driver untuk remote browser firefox
  Capybara.register_driver :remote_firefox do |app|
    cap_fox = Selenium::WebDriver::Remote::Capabilities.new
    cap_fox[:browser_name] = 'firefox'
    cap_fox[:platform_name] = 'WINDOWS'

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120 # seconds

    Capybara::Selenium::Driver.new(app, http_client: client, browser: :remote, url: 'http://localhost:4444/wd/hub', desired_capabilities: cap_fox)
  end

  # Selenium grid set up
  # code dibawah ini adalah set up driver untuk remote browser chrome
  Capybara.register_driver :remote_chrome do |app|
    cap_chrome = Selenium::WebDriver::Remote::Capabilities.new
    cap_chrome[:browser_name] = 'chrome'
    cap_chrome[:platform_name] = 'WINDOWS'

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 1200 # seconds

    Capybara::Selenium::Driver.new(app, http_client: client, browser: :remote, url: 'http://localhost:4444/wd/hub', desired_capabilities: cap_chrome)
  end
end

# dua code dibawah adalah untuk define ENVIRONMENT ketika user menjalankan runner cucumber,
# BROWSER=firefox default, dapat diganti dengan driver yang tersedia
# ENVI=int default, dapat diganti dengan envi yang di ditunjuk di hooks.rb
def env_browser_name
  (ENV['BROWSER'] ||= 'firefox')
end

def envi
  (ENV['ENVI'] ||= 'int').downcase.to_sym
end
