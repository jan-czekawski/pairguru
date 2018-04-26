require "rails_helper"

feature Comment, type: :feature do
  include Warden::Test::Helpers
  Warden.test_mode!

  scenario "should be created" do
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
      fill_in "Comment", with: Faker::Lorem.sentence(20, true)
      click_button "Add comment"
    end.to change(Comment, :count).by(1)
    expect(page).to have_content movie.comments.last.content
  end

  scenario "should be deleted" do
    comment = create(:comment)
    login_as(comment.user)

    visit root_path
    click_link "Movies"
    click_link comment.movie.title
    expect(page).not_to have_button "Add comment"
    expect { click_link "Delete" }.to change(Comment, :count).by(-1)
    expect(page).not_to have_content comment.content
    expect(page).to have_button "Add comment"
  end
end
