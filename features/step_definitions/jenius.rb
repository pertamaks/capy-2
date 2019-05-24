Given('user goto the website') do
  visit 'https://www.jenius.com/en'
end

Then('user change the language from {string} to {string}') do |lang1, lang2|
  # binding.pry
  try = 0
  begin
    try += 1
    page.find('a', exact_text: lang1, wait: 5).click
    expect(page).to have_css('a', exact_text: lang2)
  rescue RSpec::Expectations::ExpectationNotMetError
    retry if try <= 2
  end
end

Given('user on the jenius homepage') do
  expect(page).to have_title('Cara baru mengatur keuangan - Jenius')
end

When('user click menu {string}') do |value|
  page.find('a', text: value).click
end

Then('user see {string}') do |value|
  expect(page).to have_text(value)
end

When('user change the cover animation to button {int}') do |int|
  page.find_button(text: int).click
end

Then('user click on {string}') do |value|
  page.find('a', exact_text: value).click
end

Then('user close the video') do
  # binding.pry
  find('.fancybox-toolbar', visible: false).hover.click
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