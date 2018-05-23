class Grade < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  
  validates :value, presence: true,
                    numericality: { only_integer: true },
                    inclusion: { in: (1..5) }
  validates :movie_id, uniqueness: { scope: :user_id,
                                     message: "should only grade once" }
end
