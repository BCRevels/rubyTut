require './wordlist'
require './picture'
require 'colorize'

MAX_GUESSES = 5

class Game
  def initialize()
    @picture = Picture.new
    @wordlist = Wordlist.new './words.txt'
   # create instance variables for the game
  end

  def start
    setup
    mainloop
    puts @win ? "You win!" : "You loose! Word was #{@word}"
    # setup and start the game
  end

private

  def clear_screen
    # clear an ansi screen
    print "\e[H\e[2J"
  end

  def setup
    @win = false
    @over = false
    @word = @wordlist.get_word
    @guesses = MAX_GUESSES
    @messages = []
    @letters = init_letters

    # handle setting initial state and whatnot between rounds
  end

  def display_string
    # this function should display the word to guess with letters
    # and underscores
    str = ''
    @word.each_char { |letter| str += already_guessed?(letter) ? letter : "_" }
    puts str
  end

  def display_message
    # show a message to the user
    @messages.size.times {puts @messages.pop}
  end

  def display_hangman
   # display our hangman picture
   puts @picture.winning if @win
   puts @picture.image @guesses unless @win
  end

  def show_letters
    # show letters that are available to the user
    @letters.each do |letter, marked|
      if marked
        print letter.red
      else
        print letter.green
      end
      print ' '
    end
  end

  def check_guess
    @win = true and return if @guess == @word
    if @guess.size == 1
      @messages.push(already_guessed(@guess)) and return if already_guessed? @guess
      mark_letter @guess
      return @word.include? @guess
    end
    @guesses -= 1
  end

  def check_win
    win = true
    @word.each_char { |letter| win = false unless already_guessed? letter }
    @win = win
  end

  def mark_letter letter
    @letters[letter] = true
  end

  def already_guessed? letter
      @letters[letter]
  end

  def already_guessed letter
    "#{letter} was already guessed"
  end

  def mainloop
    # core game logic goes here
    loop do
      display_message
      show_letters
      display_hangman
      @over = @win || @guesses == 0
      puts "Guesses #{@guesses}"
      break if @over
      display_string
      @guess = gets.chomp.downcase
      check_guess
      check_win
    end
  end

  def init_letters
    letters = 'a'..'z'
    temp = {}
    letters.each{|letter| temp[letter] = false}
    temp
    # create a new hash with each letter set to false
  end
end
