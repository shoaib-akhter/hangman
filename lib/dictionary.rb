# frozen_string_literal: true

# Dictionary class loads words from a dictionary file and selects a random word.
class Dictionary
  DICTIONARY_PATH = File.join(File.dirname(__FILE__), 'dictionary.txt')

  def initialize
    @words = load_words
  end

  def random_word
    @words.sample || handle_empty_dictionary
  end

  private

  def load_words
    return [] unless File.exist?(DICTIONARY_PATH)

    words = File.readlines(DICTIONARY_PATH, chomp: true)
    words.select { |word| word.length.between?(5, 12) }
  end

  def handle_empty_dictionary
    raise 'Error: No words available in dictionary after filtering!'
  end
end
