class Tile
  COLORS = {
    1 => "1".blue,
    2 => "2".green,
    3 => "3".red,
    4 => "4".light_blue,
  }
    attr_reader :pos
    attr_accessor :value, :flagged, :revealed, :bomb
    def initialize(board, pos)
      @board     = board
      @pos       = pos
      @value     = nil
      @revealed  = false
      @flagged   = false
      @bomb      = false
    end
  

    def revealed?
      @revealed
    end

    def bomb?
      @bomb
    end
  
    def flagged?
      @flagged
    end

    def flag
      @flagged = !@flagged 
    end
    
    def to_s
      if flagged?
        "f"
      else
        revealed? ? value : "■"
      end
    end
       
end