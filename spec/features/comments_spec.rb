require 'rails_helper'

feature Comment, type: :feature do
  scenario "add comment" do
    user = create(:user)
    movie = create(:movie)

    visit root_path
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "Movies"
    click_link movie.title
    expect do
      fill_in "Content", with: Faker::Friends.quote
      click_button "Add comment"
    end.to change(Comment, :count).by(1)
    expect(page).to have_content movie.comments.last.content
  end
end
