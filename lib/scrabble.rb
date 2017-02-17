require 'pry'

class Scrabble
  def score(word)
    word.upcase.chars.map do |letter|
      point_values[letter]
    end.reduce(:+)
  end

  def point_values
    {
      "A"=>1, "B"=>3, "C"=>3, "D"=>2,
      "E"=>1, "F"=>4, "G"=>2, "H"=>4,
      "I"=>1, "J"=>8, "K"=>5, "L"=>1,
      "M"=>3, "N"=>1, "O"=>1, "P"=>3,
      "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
      "U"=>1, "V"=>4, "W"=>4, "X"=>8,
      "Y"=>4, "Z"=>10
    }
  end

  def score_with_multipliers(word, letter_multiplier = 1, word_multiplier = 1)
    score = 0
    long_word_bonus = 10
    word.upcase.chars.map.with_index do |char, index|
      score += (point_values[char] * letter_multiplier[index])
    end

    score += long_word_bonus if word.length >= 7
    score * word_multiplier
  end

  def highest_scoring_word(word_array)
    words_and_scores = {}
    word_array.map do |word|
      words_and_scores[word] = score_with_multipliers(word)
    end
    words_and_scores.sort_by { |word, score| score && word.length }

    top_scores = words_and_scores.select{|word,score| score == words_and_scores.values.max }
    if top_scores.select {|word, score| word.length == 7 }.any?
      top_score = top_scores.select {|word, score| word.length == 7 }
    else
      top_score = top_scores.min_by {|key, value| key.length }
    end


    if top_score.kind_of?(Array)
      [top_score].to_h.keys.join
    else
      top_score.keys.join
    end


  end
end
