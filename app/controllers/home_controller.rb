class HomeController < ApplicationController
  def welcome; end

  def top_commenters
    @commenters = User.select("users.name, COUNT(*) AS comments_count")
                      .joins(:comments)
                      .where("comments.created_at > ?", 7.days.ago)
                      .group("users.name")
                      .order("comments_count DESC")
                      .limit(10)
  end
end
