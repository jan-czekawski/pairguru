class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    if unpaired_brackets(record)
      record.errors.add :base, "This record is invalid"
    end
  end

  private

  def unpaired_brackets(movie)
    # define pair of bracket chars in a hash
    pairs = { "{" => "}", "[" => "]", "(" => ")" }
    # create hash - with 0 as default - to increase num of opening brackets
    bracket_needs_pair = Hash.new(0)
    # split movie title into letters
    letters = movie.title.chars

    letters.each_with_index do |char, idx|
      # if char is one of the opening brackets
      handle_opening(pairs, bracket_needs_pair, char, letters, idx)
      # if char is one of the closing brackets
      closing_has_no_pair =
        handle_closing(pairs, bracket_needs_pair, char)
      return true if closing_has_no_pair == true
    end
    !bracket_needs_pair.values.all?(&:zero?)
  end

  def handle_opening(pairs, bracket_needs_pair, char, letters, idx)
    if pairs.key?(char)
      # check if next char exists and is not a closing bracket of char
      if !letters[idx + 1].nil? && letters[idx + 1] != pairs[char]
        # increment count of opening brackets in hash
        bracket_needs_pair[char] += 1
      end
    end
  end

  def handle_closing(pairs, bracket_needs_pair, char)
    if pairs.value?(char)
      opening_bracket = pairs.key(char)
      # check if number of corresponding opening bracket is > 0
      if bracket_needs_pair[opening_bracket] > 0
        # found a pair => decrement opening bracket's count
        bracket_needs_pair[opening_bracket] -= 1
      else
        # found closing bracket before corresponding opening bracket => invalid
        return true
      end
    end
  end
end
