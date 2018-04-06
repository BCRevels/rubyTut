require './game'

# create a game object
hangman = Game.new

def prompt
  # ask the user if they would like to play again
  puts 'Would you like to play again? Y/N'
  answer = gets.chomp
  # check the if the answer starts with y
  answer =~ /^y.*$/i
end

loop do
  # stay in this loop until the user wants to stop playing
  hangman.start
  ans = prompt
  break unless ans
end
