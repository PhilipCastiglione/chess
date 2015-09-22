require 'gosu'

class GameWindow < Gosu::Window
  attr_accessor :board

  def initialize
    super 640, 480
    self.caption = "Motherfuckin Chess Yo"

    @wP = Gosu::Image.new('media/wP.png')
    @bP = Gosu::Image.new('media/bP.png')
    @wB = Gosu::Image.new('media/wB.png')
    @bB = Gosu::Image.new('media/bB.png')
    @wN = Gosu::Image.new('media/wN.png')
    @bN = Gosu::Image.new('media/bN.png')
    @wR = Gosu::Image.new('media/wR.png')
    @bR = Gosu::Image.new('media/bR.png')
    @wQ = Gosu::Image.new('media/wQ.png')
    @bQ = Gosu::Image.new('media/bQ.png')
    @wK = Gosu::Image.new('media/wK.png')
    @bK = Gosu::Image.new('media/bK.png')
    @board = []
  end

  def update
  end

  def draw
    @board.first.draw(50,50,0)
  end
end

#window = GameWindow.new
#window.show
