Given("user enter the carrot web") do
  visit('https://carrot.mitrais.com')
end

When("user enter the username and password") do
  within('.form-signin') do
    fill_in('username', with: 'andreas_ap634')
    fill_in('password', with: "\"S4m4r1nd4'")
  end
  click_button('Sign in')
end

Then("user can successfully login") do
  expect(page).to have_content('BAZAAR')
end

Given("user open the carrot menu") do
  click_on('Menu')
end

Then("user logout from the carrot page") do
  click_on('Logout')
  expect(page).to have_button('Sign in')
end


Given(/^user open the notification button$/) do
  click_on('Notification')
end

And(/^user select all notification$/) do
  click_on('See All Notification')
end

Then(/^user will enter the all notification menu$/) do
  expect(page).to have_content('NOTIFICATION')
end

Given(/^user on the homepage$/) do
  expect(page).to have_content('BAZAAR')
end

And(/^user enter his carrot detail$/) do
  within('#tabContent') do
    click_on('View')
  end
end

Then(/^user will see the carrot history$/) do
  expect(page).to have_content('MY EARNED HISTORY')
end

When(/^user change to shared carrot detail$/) do
  within('#tabContent > div > section.mini-dashboard.my-4 > div > div > div:nth-child(2) > div > div.col-md-8.my-auto') do
    click_on('Detail')
  end
end

Then(/^User will see the shared carrot history$/) do
  expect(page).to have_content('MY SHARED HISTORY')
end

When(/^User change to bazaar detail$/) do
  within('#tabContent > div > section.mini-dashboard.my-4 > div > div > div:nth-child(3) > div > div.col-md-8.my-auto') do
    click_on('Detail')
  end
end

Then(/^user will see the bazaar carrot history$/) do
  expect(page).to have_content('MY BAZAAR HISTORY')
end