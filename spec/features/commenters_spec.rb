require "rails_helper"

feature "Commenters", type: :feature do
  include Warden::Test::Helpers
  Warden.test_mode!

  before(:all) do
    create_list(:user, 20)
    create_list(:movie, 50)
    User.all.each do |usr|
      Movie.first(rand(1..50)).each do |movie|
        random_date = Faker::Date.between(10.days.ago, Time.zone.today)
        movie.comments.create!(user: usr,
                               content: Faker::Lorem.sentence(20, true),
                               created_at: random_date)
      end
    end

    @top_users = User.all
                     .sort_by { |usr| usr.comments.after(7.days.ago).count }
                     .last(10)
  end

  scenario "page should display 10 users with the biggest number of comments" do
    visit root_path
    login_as User.first
    click_link "Top Commenters"
    expect(current_path).to eq top_commenters_path
    @top_users.each { |user| expect(page).to have_content user.name }
  end
end
