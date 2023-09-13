import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:reto_3/utils/constants.dart';
import 'dart:math';

class TicTacToeViewModel extends BaseViewModel{

  late List<List<String>> board;
  late String currentPlayer;
  late bool isGameOver;


  TicTacToeViewModel()
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
    debugPrint('resetBoard');
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
        isGameOver = true;
      }
      else if(isBoardFull()){
        isGameOver = true;
      }
      else {
        currentPlayer = 'O';
        makeAIMove();
      }
    }
    else {
      debugPrint('not makeMove');
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
      if(isWinner('O')){
        isGameOver = true;
      }
      else if(isBoardFull()){
        isGameOver = true;
      }
      else {
        currentPlayer = 'X';
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

}