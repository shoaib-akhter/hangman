# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'player'
require_relative 'save_load'

# Game class manages Hangman game flow.
class Game
  MAX_ATTEMPTS = 6

  attr_reader :secret_word, :player, :display_word # Allows external access

  def initialize(options = {})
    @dictionary = Dictionary.new
    @secret_word = nil
    @player = nil
    @display_word = nil

    load_or_start_game(options)
  end

  def load_or_start_game(options)
    if options.empty? && ask_to_load_game
      saved_game = SaveLoad.load_game
      load_saved_game(saved_game) if saved_game
    else
      start_new_game(options)
    end
    play
  end

  def ask_to_load_game
    puts 'Do you want to load a saved game? (y/n)'
    gets.chomp.downcase == 'y'
  end

  def load_saved_game(saved_game)
    @secret_word = saved_game.secret_word
    @player = saved_game.player
    @display_word = saved_game.display_word
    puts 'Game loaded successfully!'
    play
  end

  def start_new_game(options)
    @secret_word = options[:secret_word] || @dictionary.random_word
    @player = Player.new(options[:remaining_attempts] || MAX_ATTEMPTS)
    @player.guessed_letters.concat(options[:guessed_letters] || [])
    @display_word = options[:display_word] || Array.new(@secret_word.length, '_')
  end

  def to_json(*_args)
    {
      secret_word: @secret_word,
      guessed_letters: @player.guessed_letters,
      remaining_attempts: @player.remaining_attempts,
      display_word: @display_word
    }.to_json
  end

  def play
    loop do
      display_game_state
      player_input
      break if game_over? # <-- Immediately stop when game is over
    end
    display_result
    exit # <-- Ensure the game exits properly when finished
  end

  def player_input
    puts "Enter a letter (or type 'save' to save the game):"
    input = gets.chomp.downcase
    return handle_save if input == 'save'

    process_guess(input)
  end

  def process_guess(letter)
    return if @player.guessed_letters.include?(letter)

    if @secret_word.include?(letter)
      update_display_word(letter)
    else
      @player.guessed_letters << letter # <-- Only add incorrect guesses here
      @player.reduce_attempts
    end
  end

  def update_display_word(letter)
    @secret_word.chars.each_with_index do |char, index|
      @display_word[index] = letter if char == letter
    end
  end

  def display_game_state
    puts "\nWord: #{@display_word.join(' ')}"
    puts "Incorrect guesses: #{@player.guessed_letters.join(', ')}"
    puts "Remaining attempts: #{@player.remaining_attempts}"
  end

  def game_over?
    unless @display_word.include?('_')
      puts "\nCongratulations! You guessed the word: #{@secret_word}"
      return true
    end

    if @player.remaining_attempts.zero?
      puts "\nGame Over! The word was: #{@secret_word}"
      return true
    end

    false
  end

  def display_result
    if @display_word.include?('_')
      puts "\nGame Over! The word was: #{@secret_word}"
    else
      puts "\nCongratulations! You guessed the word: #{@secret_word}"
    end
  end

  def handle_save
    SaveLoad.save_game(self)
    puts 'Game saved successfully! Exiting...'
    exit
  end
end
