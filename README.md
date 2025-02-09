# Hangman - Ruby CLI Game

## Overview
This is a command-line implementation of the classic Hangman game in Ruby. The player tries to guess a randomly selected word within a limited number of incorrect attempts. The game includes features such as saving and loading progress, ensuring a seamless experience.

## Features
- **Word Selection from Dictionary**: Randomly selects a word between 5-12 characters from `dictionary.txt`.
- **Turn-Based Gameplay**: Players guess letters one at a time, with correct guesses revealed and incorrect guesses tracked.
- **Save & Load Functionality**: Players can save their progress and resume later.
- **Rubocop Compliant**: Ensures adherence to Ruby's best practices.
- **Game Ends Correctly**: Ends as soon as the word is guessed or attempts run out.

## Project Structure
```
hangman/
│── lib/
│   ├── dictionary.rb  # Manages word selection
│   ├── player.rb      # Tracks guesses and remaining attempts
│   ├── save_load.rb   # Handles saving and loading the game state
│   ├── game.rb        # Core game logic
│── saved_games/       # Stores saved game files
│── dictionary.txt     # List of words for Hangman
│── main.rb            # Entry point to run the game
│── README.md          # Project documentation
│── .gitignore         # Files to exclude from Git tracking
```

## How to Play
### Running the Game
Run the game using:
```sh
ruby main.rb
```

### Starting or Loading a Game
Upon starting, you will be prompted:
```
Do you want to load a saved game? (y/n)
```
- **y**: Loads the saved game.
- **n**: Starts a new game.

### Guessing Letters
- Type a **single letter** (e.g., `e`) and press **Enter**.
- If the letter is in the word, it will be revealed.
- Incorrect guesses reduce remaining attempts.

### Saving Progress
At any point, type:
```
save
```
This will save the game and exit.

### Winning or Losing
- **Win:** If you guess all letters correctly, you win! 🎉
- **Lose:** If attempts run out, the game ends.

## Installation & Setup
### Install Ruby
Ensure Ruby is installed:
```sh
ruby -v
```
If not installed, download it from [Ruby's official site](https://www.ruby-lang.org/en/downloads/).

### Clone the Repository
```sh
git clone https://github.com/your-username/hangman.git
cd hangman
```

### Download the Dictionary
Ensure `dictionary.txt` is available:
```sh
curl -o lib/dictionary.txt https://raw.githubusercontent.com/dwyl/english-words/master/google-10000-english-no-swears.txt
```

### Run the Game
```sh
ruby main.rb
```

## Technologies Used
- **Ruby** 🟢 (Primary Language)
- **JSON** 📄 (For saving/loading game state)
- **Rubocop** ✅ (For code linting and best practices)

## Future Improvements
- **ASCII Hangman Drawings** 🎨 - Visual representation.
- **Colored Output** 🌈 - Using the `colorize` gem.
- **Multiplayer Mode** 👥 - Allow two players.
- **Difficulty Levels** 🎯 - Adjust number of attempts based on word length.

## License
This project is licensed under the **MIT License**.

## Contributing
Feel free to fork the repository, create a new branch, and submit a pull request! Contributions are welcome. 🚀

