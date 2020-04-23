class Game
  def initialize(board,pos)
      @board = board.new(4, 2)
      @pos = pos
  end

end


while(q.Count > 0)
  {
      Coord c = q.Dequeue();
      if(m.tiles[c.x, c.y].surroundingMines != 0)
      {
          continue;
      }
      
      for(int relativeX = -1; relativeX != 2; relativeX++)
      {
          for(int relativeY = -1; relativeY != 2; relativeY++)
          {
              int nearX = c.x + relativeX;
              int nearY = c.y + relativeY;

              if (nearX < 0 || nearX > m.width - 1 || nearY < 0 || nearY > m.height - 1)
              {
                  continue;
              }
              
              if(!m.tiles[nearX, nearY].uncovered && !m.tiles[nearX, nearY].flagged)
              {
                  q.Enqueue(new Coord(nearX, nearY));
              }

              m.tiles[nearX, nearY].uncovered = true;
          }
      }
  }

  return m;
}