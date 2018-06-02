
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts" #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your #valid_move? method here
def valid_move?(board, index)
  if index.between?(0,8)
    if !(position_taken?(board,index))
      TRUE
    else
      FALSE
    end
  end
end

#input_to_index method
def input_to_index(input)
  index = input.to_i - 1
end
#move method
def move(board,index, player)
  board[index] = player
end

#turn method
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
  display_board(board)
end

#current_player method
def current_player(board)
  if (turn_count(board)) % 2 == 0
    return "X"
  else 
    return "O"
  end
end

#turn_count method
def turn_count(board)
  counter = 0
  index = 0
  while index < board.length
    if (board[index] == "X" || board[index] == "O")
      counter += 1
    end
    index += 1
  end
  return counter
end

#position_taken method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

#full method
def full?(board)
  index = 0
  while index < board.length
    if board[index] == " " then
      return false
    end
    index += 1
  end
  return true
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]]

#won method
def won?(board) 
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = board[win_combination[0]] 
    position_2 = board[win_combination[1]] 
    position_3 = board[win_combination[2]] 
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||(position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination 
    end
  end
  return false
end

#draw method
def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

#over method
def over?(board)
  if !(full?(board)) && won?(board) == false
    false
  elsif won?(board) || draw?(board)
    true
  else
    false
  end
end

#winner method
def winner(board)
  if won?(board)
    win_combination = won?(board)
    if board[win_combination[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  until (over?(board) || draw?(board))
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end