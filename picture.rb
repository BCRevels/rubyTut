class Picture
  def initialize()
    # store the pictures
    @pictures = File.read("./pictures.txt").split(',')
  end

  def winning
    #get the winning picture
    @pictures[6]
  end

  def image num
    # display a picture based on game status
    @pictures[num]
  end

end
