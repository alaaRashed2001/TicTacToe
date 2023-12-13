import 'dart:io';

class TicTacToe {
  late List<List<String>> board;
 late String currentPlayer;

  TicTacToe() {
    board = List.generate(3, (_) => List.filled(3, ' '));
    currentPlayer = 'X';
  }

  void printBoard() {
    for (var row in board) {
      print(row.join(' | '));
      print('---------');
    }
  }

  bool makeMove(int position) {
    int row = (position - 1) ~/ 3;
    int col = (position - 1) % 3;

    if (position < 1 || position > 9 || board[row][col] != ' ') {
      print('Invalid move. Please try again.');
      return false;
    }

    board[row][col] = currentPlayer;
    return true;
  }

  bool checkWin() {
    // Check rows, columns, and diagonals for a win
    for (var i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer &&
          board[i][1] == currentPlayer &&
          board[i][2] == currentPlayer) {
        return true; // Check row
      }
      if (board[0][i] == currentPlayer &&
          board[1][i] == currentPlayer &&
          board[2][i] == currentPlayer) {
        return true; // Check column
      }
    }

    if (board[0][0] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][2] == currentPlayer) {
      return true; // Check diagonal
    }

    if (board[0][2] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][0] == currentPlayer) {
      return true; // Check reverse diagonal
    }

    return false;
  }

  bool isBoardFull() {
    for (var row in board) {
      if (row.contains(' ')) {
        return false;
      }
    }
    return true;
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void play() {
    print('Welcome to Tic-Tac-Toe!');
    printBoard();

    while (true) {
      print('\n$currentPlayer\'s turn. Enter your move (1-9): ');

      var move = int.tryParse(stdin.readLineSync() ?? '');

      if (move != null && makeMove(move)) {
        printBoard();

        if (checkWin()) {
          print('$currentPlayer wins!');
          break;
        }

        if (isBoardFull()) {
          print('It\'s a draw!');
          break;
        }

        switchPlayer();
      }
    }

    print('Do you want to play again? (y/n)');
    var playAgain = stdin.readLineSync()?.toLowerCase();
    if (playAgain == 'y') {
      resetGame();
      play();
    } else {
      print('Thanks for playing!');
    }
  }

  void resetGame() {
    board = List.generate(3, (_) => List.filled(3, ' '));
    currentPlayer = 'X';
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.play();
}
