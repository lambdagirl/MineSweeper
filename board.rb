require "colorize"
require_relative "tile"

COLORS = {
            1 => "1".blue,
            2 => "2".green,
            3 => "3".red,
            4 => "4".light_blue,
          }

DELTA = [[0,1],[0,-1],[1,1],[1,0],[1,-1],[-1,0],[-1,-1],[-1,1]]

class Board
  attr_reader :size, :num_bombs
  attr_accessor :grid

  def initialize(size=4,num_bombs)
    @size = size
    @num_bombs = num_bombs
    @grid = Array.new(size) do |row|
      Array.new(size) { |col| Tile.new(self, [row, col]) }
    end
    @gameover = false
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
      if !self[rand_pos].value != "bomb"
        self[rand_pos].value = "bomb"
        self[rand_pos].bomb = true
        total_bombs += 1
      end
      end
    nil
  end

  def valid?(pos)
    pos.all? do |i|
        0 <= i && i < size
    end
  end


  def get_neighbors(pos)
    n = []
    DELTA.each do |d|
      neighbor_pos = [(pos[0] + d[0]), (pos[1] + d[1])]
      if valid?(neighbor_pos) 
        n << neighbor_pos
      end
    end
    n
  end



  def check_surrounding_bombs(pos)
    return "gameover!" if self[pos].value == "bomb" 

    if valid?(pos)
      count = 0
        DELTA.each do |d|
          neighbor_pos = [(pos[0] + d[0]), (pos[1] + d[1])]
          if valid?(neighbor_pos) && self[neighbor_pos].value == 'bomb'
            count +=1
          end
        end
      self[pos].value = count.to_s
      self[pos].revealed = true
    count

    end
  end

  def to_s
    puts "  #{(0...size).to_a.join(' ')}"
    grid.each_with_index do |row,i|
        puts "#{i} #{row.join(' ')}"
    end
  end


  def flood_fill(pos)
    q = []
    q << pos
    while q.length > 0
      current_pos = q.shift
      if check_surrounding_bombs(current_pos) == 0
        neighbors = get_neighbors(current_pos)
        neighbors.each do |n|
          if !self[n].revealed? && !self[n].flagged?
            q << n
          end
        end
      self[current_pos].revealed = true 
      end
    end
    pos
  end

  def choose(pos)
    raise ArgumentError, "Position not valid!" unless valid?(pos)
    if self[pos].bomb? 
      @gameover = true
    else
      flood_fill(pos)
    end
  end

  def gameover?
    @gameover
  end

  def won?
    count = 0
    grid.each do |rows|
      rows.each do |tile|
          tile.revealed?
          count+=1
      end
    end
    count == size*size - num_bombs
  end



end



if $PROGRAM_NAME == __FILE__
  b = Board.new(4, 2)
  b.choose([1,1])
  puts b

end