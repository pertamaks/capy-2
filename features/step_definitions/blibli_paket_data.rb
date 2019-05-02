Given(/^User enter the blibli$/) do
  visit('https://www.blibli.com')
end

Then(/^user reach blibli homepage$/) do
  expect(page).to have_title('Online Mall Blibli.com, Sensasi Belanja Online Shop ala Mall')
end

Given(/^User go to paket data page$/) do
  terms_window = window_opened_by do
    click_on('Paket Data')
  end
  switch_to_window(terms_window)
end

And(/^User enter the phone number$/) do
  #expect(page).to have_title('Jual Paket Data All Operator - Kuota Internet Harga Murah | Blibli.com')
  within('#blibli-main-ctrl > section.content-section.relocate-header > div > div:nth-child(3) > div > div > div.form > div.form__input-wrapper > div.form__input.relative') do
    fill_in('contoh: 081234567890', with: '08137382789')

  end
  sleep(3)
end

And(/^User select the paket data$/) do
    choose('Data 50.000')
end

And(/^User click beli sekarang$/) do
  click_button('Beli Sekarang')
end

Then(/^Quick register form will appear$/) do
  page.should have_css('.quick-register')
end