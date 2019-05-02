Given(/^User enter the Gotix website$/) do
  visit('https://go-tix.id/')
end

Then(/^User reach the homepage$/) do
  expect(page).to have_title('GO-TIX: Beli Tiket Nonton Bioskop Online CGV, Cinemaxx, Konser, Dll')
end

Given(/^User on the homepage$/) do
  expect(page).to have_title('GO-TIX: Beli Tiket Nonton Bioskop Online CGV, Cinemaxx, Konser, Dll')
end

And(/^User go to the movies menu$/) do
  click_on('Movies')
end

When(/^User see the avenger endgame poster$/) do
  within('#movies') do
    expect(page).to have_content('AVENGERS: ENDGAME')
  end
end

Then(/^User open the trailer$/) do
  within(find('#movies > div > div.uk-width-1-1.uk-grid-margin.uk-first-column > div > div:nth-child(1) > div > div > div').hover) do
    click_on('WATCH TRAILER')
  end
end