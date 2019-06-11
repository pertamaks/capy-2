Before do |scenario|
  # dibawah adalah code agar cucumber dapat dijalankan secara pararel dengan memanfaatkan fungsi ENV,
  # jangan lupa untuk define envi dan env_browser_name di file env.rb
  p "Starting #{scenario}"
  if envi == :node
    Capybara.default_driver = "remote_#{env_browser_name}".downcase.to_sym
  elsif envi == :mobile
    Capybara.default_driver = "mobile_#{env_browser_name}".downcase.to_sym
  elsif envi == :emu
    Capybara.default_driver = "emu_#{env_browser_name}".downcase.to_sym
  elsif envi == :local
    Capybara.default_driver = env_browser_name.downcase.to_sym
  end
  #page.driver.browser.manage.window.resize_to(1024, 700)

  # code dibawah digunakan untuk setting Capybara-Screenshot gems, agar gem dapat melakukan auto save ketika ada scenario yang gagal
  # dengan menunjuk driver yang di perintahkan user ketika menjalankan command cucumber
  # page.driver.browser.capabilities[:browser_name].to_sym ini adalah code yang dimaksud
  Capybara::Screenshot.register_driver(page.driver.browser.capabilities[:browser_name].to_sym) do |driver, path|
    driver.browser.save_screenshot path
  end
  # dibawah ini adalah setting Path untuk Capybara-Screenshot agar save point dapat dirubah sesuai keinginan
  if page.driver.browser.capabilities[:browser_name].include? 'chrome'
    Capybara.save_path = 'E:\\GIT-AUTO\\capy 2\\Chrome Screenshot'
  elsif page.driver.browser.capabilities[:browser_name].include? 'firefox'
    Capybara.save_path = 'E:\\GIT-AUTO\\capy 2\\Firefox Screenshot'
  end
end

  # code dibawah ini digunakan untuk mendelete folder screenshot yang diambil di percobaan sebelumnya, 
  # code akan mendelete semua folder yang dimaksudkan sebelum memulai testing.
AfterConfiguration do
  FileUtils.rm_r('Chrome Screenshot') if File.directory?('Chrome Screenshot')
  FileUtils.rm_r('Firefox Screenshot') if File.directory?('Firefox Screenshot')
end
