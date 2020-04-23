require "colorize"
  COLORS = {
    1 => "1".blue,
    2 => "2".green,
    3 => "3".red,
    4 => "4".light_blue,

}

class Board
  attr_reader :size, :num_bombs
  attr_accessor :grid
  def initialize(size=4,num_bombs)
    @size = size
    @num_bombs = num_bombs
    @grid = Array.new(size) { Array.new(size,"■")}
    generate_bombs
  end
  
  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos,val)
    row, col = pos
    grid[row][col] = val
  end

  def generate_bombs
    total_bombs = 0
    while total_bombs < @num_bombs
      rand_pos = Array.new(2) { rand(size) }
      if self[rand_pos] != "b"
        self[rand_pos] = "b"
        total_bombs += 1
      end
      end
    nil
  end

  # def neighbors 
  # end

  def check_surrounding_bombs(pos)
    count = 0
    delta = [[0,1],[0,-1],[1,1],[1,0],[1,-1],[-1,0],[-1,-1],[-1,1]]
    if self[pos] != 'b'
      delta.each do |d|
        if self[[(pos[0] + d[0]), (pos[1] + d[1])]] == 'b'
          count +=1
        end
      end
    end
    self[pos] = count
  end


  def to_s
    puts "  #{(0...size).to_a.join(' ')}"
    grid.each_with_index do |row,i|
        puts "#{i} #{row.join(' ')}"
    end
  end

end


if $PROGRAM_NAME == __FILE__
  b = Board.new(4, 2)
  puts b
  b.check_surrounding_bombs([1,1])
  puts b

  require 'pry'; binding.pry
end