require 'rails_helper'

describe Comment do
  context "with all required information" do
    it "is valid" do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end

  context "with no information about user" do
    it "is invalid" do
      comment = build(:comment, user: nil)
      expect(comment).not_to be_valid
    end
  end

  context "with no information about movie" do
    it "is invalid" do
      comment = build(:comment, movie: nil)
      expect(comment).not_to be_valid
    end
  end

  context "with no content" do
    it "is invalid" do
      comment = build(:comment, content: nil)
      expect(comment).not_to be_valid
    end
  end

  context "when user had already commented on selected movie" do
    it "is invalid" do
      movie = create(:movie)
      user = create(:user)
      create(:comment, movie: movie, user: user)
      comment = build(:comment, movie: movie, user: user)
      expect(comment).not_to be_valid
    end
  end
end
