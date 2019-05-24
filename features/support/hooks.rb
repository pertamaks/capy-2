Before do |scenario|
  p "Starting #{scenario}"
  if envi == :node
    Capybara.default_driver = "remote_#{env_browser_name}".downcase.to_sym
  elsif envi == :local
    Capybara.default_driver = env_browser_name.downcase.to_sym
  end
  page.driver.browser.manage.window.resize_to(1024, 700)

  # 
  # Set up Capybara-Screenshot
  # 
  # The driver name should match the Capybara driver config name.
  Capybara::Screenshot.register_driver(page.driver.browser.capabilities[:browser_name].to_sym) do |driver, path|
    driver.browser.save_screenshot path
  end

  if page.driver.browser.capabilities[:browser_name].include? "chrome"
    Capybara.save_path = "E:\\GIT-AUTO\\capy 2\\Chrome Screenshot"
  elsif page.driver.browser.capabilities[:browser_name].include? "firefox"
    Capybara.save_path = "E:\\GIT-AUTO\\capy 2\\Firefox Screenshot"
  end
end

AfterConfiguration do
  FileUtils.rm_r('Chrome Screenshot') if File.directory?('Chrome Screenshot')
  FileUtils.rm_r('Firefox Screenshot') if File.directory?('Firefox Screenshot')
end
