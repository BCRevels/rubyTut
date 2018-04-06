class Wordlist
  def initialize(filePath, difficulty=1)
    # create instance variables for the wordlist
    @filePath = filePath
    @difficulty = difficulty
    @words = []
  end

  def get_word
    init_words if @words.empty?
    @words.pop
    # get a word from the list of words
  end

private
  def init_words
    @words = File.read(@filePath).split("\n").shuffle

    case @difficulty
    when 1
      wordsize = 5
    when 2
      wordsize = 10
    when 3
      wordsize = 100
    else
      wordsize = 5
    end
    @words = @words.find_all {|word| word.size <= wordsize}
    # create the word list and filter by difficulty
  end


end
