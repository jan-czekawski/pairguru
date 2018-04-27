require "rails_helper"

describe Comment do
  shared_examples "has all required information" do
    it "should be valid" do
      expect(comment).to be_valid
    end
  end

  shared_examples "doesn't have all required information" do
    it "should not be valid" do
      expect(comment).not_to be_valid
    end
  end
  
  context "with user_id, movie_id and content" do
    let(:comment) { build(:comment) }
    it_behaves_like "has all required information"
  end

  context "with no user_id" do
    let(:comment) { build(:comment, user_id: nil) }
    it_behaves_like "doesn't have all required information"
  end

  context "with no movie_id" do
    let(:comment) { build(:comment, movie_id: nil) }
    it_behaves_like "doesn't have all required information"
  end

  context "with no content" do
    let(:comment) { build(:comment, content: nil) }
    it_behaves_like "doesn't have all required information"
  end

  context "when user had already commented on selected movie" do
    it "is invalid" do
      comment = create(:comment)
      new_comment = build(:comment, movie: comment.movie, user: comment.user)
      expect(new_comment).not_to be_valid
    end
  end
end
