class Tile

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
      @flagged = true
    end
    
    def to_s
      if flagged?
        "f"
      else
        revealed? ? value.to_s : "■"
      end
    end
       
end