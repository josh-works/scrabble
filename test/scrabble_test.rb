gem 'minitest'
require_relative '../lib/scrabble'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class ScrabbleTest < Minitest::Test
  def test_it_can_score_a_single_letter
    assert_equal 1, Scrabble.new.score("a")
    assert_equal 4, Scrabble.new.score("f")
  end

  def test_score_with_letter_multipliers

    game = Scrabble.new
    score = game.score_with_multipliers('hello', [1,2,1,1,1])
    assert_equal 9, score
  end

  def test_score_with_word_multipliers

    game = Scrabble.new
    score = game.score_with_multipliers('hello', [1,2,1,1,1], 2)
    assert_equal 18, score
  end

  def test_long_word_bonus
    game = Scrabble.new
    score = game.score_with_multipliers('sparkle', [1,2,1,3,1,2,1], 2)
    assert_equal 58, score
  end

  def test_highest_scoring_word
    game = Scrabble.new
    highest_scoring_word = game.highest_scoring_word(['home', 'word', 'hello', 'sound'])
    assert_equal "home", highest_scoring_word
  end

  def test_highest_scoring_word_of_same_score
    game = Scrabble.new
    highest_scoring_word = game.highest_scoring_word(['hello', 'word', 'sound'])
    assert_equal "word", highest_scoring_word
  end

  def test_highest_scoring_word_of_tie_can_be_seven_letters
    game = Scrabble.new
    highest_scoring_word = game.highest_scoring_word(['home', 'word', 'silence'])
    assert_equal "silence", highest_scoring_word
  end
end
