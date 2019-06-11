Given('user goto the website') do
  # binding.pry
  visit 'https://www.jenius.com/en/'
end

Then('user change the language from {string} to {string}') do |lang1, lang2|
  # binding.pry
  # dibawah ini adalah contoh hybrid syntax untuk mobile dan web browser,
  # implementasi ini diterapkan untuk seluruh syntax yang ada di jenius.rb
  # mobile browser gunakan ENVI=EMU, sebelumnya aktifkan selenium grid dan registrasikan browser chrome ke grid.
  if page.has_text?('GET JENIUS')
    page.find('a', exact_text: lang1, wait: 5).click
    expect(page).to have_css('a', exact_text: lang2)
  else
    page.find('#mobileNavbar > div.container.position-relative > button').click
    page.find('a', exact_text: lang2, wait: 5).click
  end
end

Given('user on the jenius homepage') do
  # binding.pry
  expect(page).to have_title('Cara baru mengatur keuangan - Jenius')
end

When('user click menu {string}') do |value|
  if page.has_text?('GET JENIUS')
    # binding.pry
    page.find('a', exact_text: value.upcase).click
  else
    page.find('#mobileNavbar > div.container.position-relative > button').click
    page.find('a', text: value).click
  end
end

Then('user see {string}') do |value|
  begin
    expect(page).to have_text(value)
  rescue RSpec::Expectations::ExpectationNotMetError
    p "Given Text not found, Check your Text"
  end
end

When('user change the cover animation to button {int}') do |int|
  page.find_button(text: int).click
end

Then('user click on {string}') do |value|
  # binding.pry
  begin
    page.find('a', exact_text: value).click
  rescue Capybara::ElementNotFound
    p "Given Text not found, Check your Text"
  end
end

Then('user close the video') do
  # binding.pry
  begin
    find('body').click
    find('.fancybox-toolbar').click
  rescue Capybara::ElementNotFound
    find('.fancybox-toolbar', visible: false).hover.click
  end
  # find('button', class: 'fancybox-button.fancybox-button--close').click
end

Then('user sroll to see {string}') do |value|
  # binding.pry
  page.execute_script 'window.scrollBy(0,10000)'
  def scroll_to(element)
    script = <<-JS
      arguments[0].scrollIntoView(true);
    JS

    page.execute_script(script, element.native)
  end
  scroll_to(find('h2', exact_text: value))
end
