class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :base, "Invalid record" if unpaired_brackets?(record)
  end

  private

  def unpaired_brackets?(movie)
    pairs = { "{" => "}", "[" => "]", "(" => ")" }
    bracket_needs_pair = Hash.new(0)
    letters = movie.title.chars

    letters.each_with_index do |char, idx|
      handle_opening(pairs, bracket_needs_pair, char, letters, idx)
      closing_has_no_pair =
        handle_closing(pairs, bracket_needs_pair, char)
      return true if closing_has_no_pair == true
    end
    !bracket_needs_pair.values.all?(&:zero?)
  end

  def handle_opening(pairs, bracket_needs_pair, char, letters, idx)
    if pairs.key?(char)
      if !letters[idx + 1].nil? && letters[idx + 1] != pairs[char]
        bracket_needs_pair[char] += 1
      end
    end
  end

  def handle_closing(pairs, bracket_needs_pair, char)
    if pairs.value?(char)
      opening_bracket = pairs.key(char)
      count = bracket_needs_pair[opening_bracket]
      return true if count <= 0
      bracket_needs_pair[opening_bracket] -= 1 if count > 0
    end
  end
end
