import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:reto_3/utils/constants.dart';
import 'dart:math';

class TicTacToeViewModel extends BaseViewModel{

  late List<List<String>> board;
  late String currentPlayer;
  late bool isGameOver;
  String dialogMessage = '';
  String dialogTitle = '';

  late BuildContext context;


  TicTacToeViewModel({required this.context})
  {
    board = List.generate(NUM_ROWS, (_) => List.generate(NUM_ROWS, (_) => ''));
    currentPlayer = HUMAN_PLAYER;
    isGameOver = false;
  }

  void play(int row, int col){
    if(board[row][col] == ''){
      makeMove(row, col);
    }
  }

  Color colorCell(BuildContext context, int row, int col){
    if(board[row][col] == HUMAN_PLAYER) return Theme.of(context).colorScheme.background;

    return Theme.of(context).colorScheme.primary;
  }

  void resetBoard(){
    const int rows = NUM_ROWS;
    const int cols = NUM_COLS;

    for(int row = 0; row < rows; row++){
      for(int col = 0; col < cols; col++){
        board[row][col] = '';
      }
    }
    currentPlayer = HUMAN_PLAYER;
    isGameOver = false;
    notifyListeners();
  }


  int minmax(List<List<String>> board, int depth, bool isMaximizing) {
    if (isMaximizing) {
      int bestScore = WORST_SCORE;
      for (int i = 0; i < NUM_ROWS; i++) {
        for (int j = 0; j < NUM_COLS; j++) {
          if (board[i][j] == '') {
            board[i][j] = AI_PLAYER;
            int score = minmax(board, depth + 1, false);

            // Deshacer el movimiento
            board[i][j] = '';

            bestScore = max(score, bestScore);
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = BEST_SCORE;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == '') {
            board[i][j] = HUMAN_PLAYER;
            int score = minmax(board, depth + 1, true);

            // Deshacer el movimiento
            board[i][j] = '';

            bestScore = min(score, bestScore);
          }
        }
      }
      return bestScore;
    }
  }


  bool isBoardFull(){
    for(int i = 0; i < 3; i++){
      for(int j = 0; j < 3; j++){
        if(board[i][j] == '') return false;
      }
    }
    return true;
  }


  void makeMove(int row, int col){
    if(board[row][col] == '' && !isGameOver){

      board[row][col] = currentPlayer;
      notifyListeners();

      if(isWinner(currentPlayer)){
        showDialogMessage(HUMAN_PLAYER, false);
        isGameOver = true;
      }
      else if(isBoardFull()){
        showDialogMessage("", true);
        isGameOver = true;
      }
      else {
        currentPlayer = AI_PLAYER;
        makeAIMove();
      }
    }
  }


  void makeAIMove(){
    int bestScore = -500;
    int row = -1;
    int col = -1;

    for(int i = 0; i < NUM_ROWS; i++){
      for(int j = 0; j < NUM_COLS; j++){
        if(board[i][j] == ''){
          int score = minmax(board, 0, false);
          board[i][j] = '';
          if(score > bestScore){
            bestScore = score;
            row = i;
            col = j;
          }
        }
      }
    }

    if(row != -1 && col != -1){
      board[row][col] = 'O';
      if(isWinner(AI_PLAYER)){
        showDialogMessage(AI_PLAYER, false);
        isGameOver = true;
      }
      else if(isBoardFull()){
        showDialogMessage("" , true);
        isGameOver = true;
      }
      else {
        currentPlayer = HUMAN_PLAYER;
      }
    }

    notifyListeners();
  }


  bool isWinner(String player) {
    for (int i = 0; i < NUM_ROWS; i++) {
      if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
        return true;
      }
    }

    for (int j = 0; j < NUM_COLS; j++) {
      if (board[0][j] == player && board[1][j] == player && board[2][j] == player) {
        return true;
      }
    }

    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
      return true;
    }
    if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
      return true;
    }


    return false;
  }


  void showDialogMessage(String winnerPlayer, bool isDraw){
    if(winnerPlayer == HUMAN_PLAYER){
      dialogTitle = 'Ganaste!';
      dialogMessage = 'Has ganado a la IA!';

      showAlert();
    }
    else if(winnerPlayer == AI_PLAYER){
      dialogTitle = 'Perdiste!';
      dialogMessage = 'La IA gana!';

      showAlert();
    }
    else if(isDraw){
      dialogTitle = 'Empate!';
      dialogMessage = 'Ambos jugadores empatan';

      showAlert();
    }
    else {
      dialogTitle = '';
      dialogMessage = '';
    }

    notifyListeners();
  }

  void showAlert(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            dialogTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: Text(
            dialogMessage,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: [
            TextButton(
              onPressed: () {
                resetBoard();
                Navigator.pop(context);
              },
              child: const Text('Reiniciar'),
            ),
          ],
        );
      },
    );
  }

}