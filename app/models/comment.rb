class Comment < ApplicationRecord
  include HandleErrors
  belongs_to :user
  belongs_to :movie
  validates :content, presence: true
  validates :movie_id, uniqueness: { scope: :user_id,
                                     message: "should only comment once" }
end
