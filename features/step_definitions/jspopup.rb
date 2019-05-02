Given("user visit the webpage") do
  visit('https://the-internet.herokuapp.com/')
end

Given("user go to JS pop up page") do
  expect(page).to have_content('Welcome to the-internet')
  click_link('JavaScript Alerts')
end

When("user select and accept the pop up") do
  expect(page).to have_content('JavaScript Alert')
  click_button('Click for JS Alert')
  page.accept_alert
end

Then("the result will accept the pop up") do
  expect(page).to have_content('You successfuly clicked an alert')
end

When("user select the second JS and dismissed the pop up") do
  expect(page).to have_content('JavaScript Alert')
  click_button('Click for JS Confirm')
  page.dismiss_confirm
end

Then("ther result will cancel the pop up") do
  expect(page).to have_content('You clicked: Cancel')
end

When("user select the third JS and send aiueo") do
  expect(page).to have_content('JavaScript Alert')
  click_button('Click for JS Prompt')
  page.accept_prompt(with:'aiueo')
end

Then("ther result will show aiueo") do
  expect(page).to have_content('You entered: aiueo')
end
