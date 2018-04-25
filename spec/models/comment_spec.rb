require 'rails_helper'

describe Comment do
  context "all required info is provided" do
    it "builds valid comment" do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end
  
  context "user is not provided" do
    it "builds invalid comment" do
      comment = build(:comment, user: nil)
      expect(comment).not_to be_valid
    end
  end
  
  context "movie is not provided" do
    it "builds invalid comment" do
      comment = build(:comment, movie: nil)
      expect(comment).not_to be_valid
    end
  end
  
  context "content is not provided" do
    it "builds invalid comment" do
      comment = build(:comment, content: nil)
      expect(comment).not_to be_valid
    end
  end
end
