class TicTacToe
  def initialize(board)
    @board = board
    @players = %w[x o]
  end

  def validate
    validate_char && validate_size
  end

  def validate_char
    @board.flatten.uniq.all? { |e| ['x', 'o', ' '].include?(e) }
  end

  def validate_size
    @board.all? { |row| row.count == @board.count}
  end

  def winner
    return 'enter a valid board' unless validate

    # Row checks
    winner = rows_check
    return winner if @players.include?(winner)

    # column checks
    winner = rows_check(@board.transpose)
    return winner if @players.include?(winner)

    # diagonal checks
    winner = diagonal_check
    return winner if @players.include?(winner)

    # unfinished check
    return 'unfinished' if @board.flatten.include?(' ')

    'draw'
  end

  def rows_check(board = @board)
    board.each do |row|
      return row[0] if row_check(row)
    end
  end

  def row_check(row)
    row.all? { |e| !e.strip.empty? && e == row[0] }
  end

  def diagonal_check
    define_diagonals

    return @diagonal_x[0] if row_check(@diagonal_x)

    @diagonal_y[0] if row_check(@diagonal_y)
  end

  def define_diagonals
    @diagonal_x = []
    @diagonal_y = []

    (0..@board.size - 1).each do |i|
      @diagonal_x << @board[i][i]
      @diagonal_y << @board[i][-i - 1]
    end
  end
end
