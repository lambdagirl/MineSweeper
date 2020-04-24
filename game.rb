require_relative "board"
class Play
      LAYOUTS = { 9=> 10,16=> 40,32=>160}
      def initialize(size)
        puts "> Welcome to Minesweeper!".colorize(:yellow)
        @size =get_size
        @board = Board.new(@size, LAYOUTS[@size])
      end
    
      def play
        until @board.won? || @board.gameover?
          system("clear") 
          puts "[e]xplore | [f]lag ,<height>, <width>".colorize(:blue)
          puts @board
          action, pos = get_move
          perform_move(action, pos)
        end
    
        if @board.won?
          puts "You win!"
        elsif @board.gameover?
          @board.reveal
          puts @board
          puts "**Bomb hit!**".colorize(:red)
          puts "GAME OVER!".colorize(:red)
        end
      end
    
      private
    
      def get_size
        puts "Set the game size - 'small' (9x9 , 10 bombs), 'medium' (16x16 ,40 bombs) or 'large' (32x32 ,160 bombs) "
        loop do
          puts "Please enter s, m, or l".colorize(:yellow)
          difficulty = gets.chomp.downcase
          return 9 if difficulty == "s"
          return 16 if difficulty == "m"
          return 32 if difficulty == "l"
        end
      end

      def get_move
        action_type, row_s, col_s = gets.chomp.split(",")
        [action_type, [row_s.to_i, col_s.to_i]]
      end
    
      def perform_move(action_type, pos)
        tile = @board[pos]
        case action_type
        when "f"
          tile.flag
        when "e"
         @board.choose(pos)
      end
    end
    
    if $PROGRAM_NAME == __FILE__    
      case ARGV.count
      when 0
        Play.new(:small).play
      when 1
        YAML.load_file(ARGV.shift).play
      end
    end
end