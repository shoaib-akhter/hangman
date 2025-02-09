# frozen_string_literal: true

require 'json'

# SaveLoad class handles saving and loading the game state.
class SaveLoad
  SAVE_FILE = 'saved_games/hangman_save.json'

  def self.save_game(game)
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    File.write(SAVE_FILE, game.to_json)
    puts 'Game saved successfully!'
  end

  def self.load_game
    return unless File.exist?(SAVE_FILE)

    data = begin
      JSON.parse(File.read(SAVE_FILE), symbolize_names: true)
    rescue JSON::ParserError
      puts 'Error: Save file is corrupted.'
      return
    end

    Game.new(**data)
  end
end
