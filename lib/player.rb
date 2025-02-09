# frozen_string_literal: true

# Player class keeps track of guessed letters and remaining attempts.
class Player
  attr_reader :guessed_letters, :remaining_attempts

  def initialize(max_attempts)
    @guessed_letters = []
    @remaining_attempts = max_attempts
  end

  def guess(letter)
    return false if @guessed_letters.include?(letter)

    @guessed_letters << letter
    true
  end

  def reduce_attempts
    @remaining_attempts -= 1 if @remaining_attempts.positive?
  end
end
