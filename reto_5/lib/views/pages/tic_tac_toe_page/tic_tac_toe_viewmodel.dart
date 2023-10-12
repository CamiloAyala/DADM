import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:reto_5/utils/constants.dart';

class TicTacToeViewModel extends BaseViewModel{

  late List<List<String>> board;
  late String currentPlayer;
  late bool isGameOver;
  String dialogMessage = '';
  String dialogTitle = '';
  Difficulty dificultad = Difficulty.easy;
  AudioPlayer audioPlayer = AudioPlayer();
  final String xAudioPath = 'assets/X_audio.wav';
  final String oAudioPath = 'assets/O_audio.wav';

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void onChangeIndex(int index){
    _currentIndex = index;
    if(index == 1){
      showDifficultyAlert();
    }
    notifyListeners();
  }

  late BuildContext context;


  TicTacToeViewModel({required this.context})
  {
    board = List.generate(numRows, (_) => List.generate(numRows, (_) => ''));
    currentPlayer = humanPlayer;
    isGameOver = false;
  }

  void play(int row, int col){
    if(board[row][col] == ''){
      makeMove(row, col);
    }
  }

  Color colorCell(BuildContext context, int row, int col){
    if(board[row][col] == humanPlayer) return Theme.of(context).colorScheme.background;

    return Theme.of(context).colorScheme.primary;
  }

  void resetBoard(){
    const int rows = numRows;
    const int cols = numCols;

    for(int row = 0; row < rows; row++){
      for(int col = 0; col < cols; col++){
        board[row][col] = '';
      }
    }
    currentPlayer = humanPlayer;
    isGameOver = false;
    notifyListeners();
  }


  bool isBoardFull(){
    for(int i = 0; i < 3; i++){
      for(int j = 0; j < 3; j++){
        if(board[i][j] == '') return false;
      }
    }
    return true;
  }


  Future<void> makeMove(int row, int col) async {
    if(board[row][col] == '' && !isGameOver){

      board[row][col] = currentPlayer;
      notifyListeners();

      ByteData xAudio = await rootBundle.load(xAudioPath);
      Uint8List xAudioList = xAudio.buffer.asUint8List();
      await audioPlayer.play(BytesSource(xAudioList));

      sleep(const Duration(milliseconds: 300));


      if(isWinner(currentPlayer)){
        showDialogMessage(humanPlayer, false);
        isGameOver = true;
      }
      else if(isBoardFull()){
        showDialogMessage("", true);
        isGameOver = true;
      }
      else {
        currentPlayer = aiPlayer;
        makeAIMove();
      }
    }
  }


  Future<void> makeAIMove() async {
    if(dificultad == Difficulty.easy){
      makeRandomMove();
    }
    else if(dificultad == Difficulty.medium){
      makeBlockingMove();
    }
    else if(dificultad == Difficulty.hard){
      makeWinningMove();
    }

    ByteData oAudio = await rootBundle.load(oAudioPath);
    Uint8List oAudioList = oAudio.buffer.asUint8List();
    await audioPlayer.play(BytesSource(oAudioList));

    if(isWinner(aiPlayer)){
      showDialogMessage(aiPlayer, false);
      isGameOver = true;
    }
    else if(isBoardFull()){
      showDialogMessage("" , true);
      isGameOver = true;
    }
    else {
      currentPlayer = humanPlayer;
    }

    notifyListeners();
  }

  void makeRandomMove()
  {
    final random = Random();
    int row = random.nextInt(numRows);
    int col = random.nextInt(numCols);

    if (board[row][col] == '') {
      board[row][col] = aiPlayer;
    }
    else {
      makeRandomMove();
    }

    notifyListeners();
  }

  void makeBlockingMove() 
  {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == '') {
          // Simula un movimiento del jugador humano para evaluar el resultado.
          board[row][col] = humanPlayer;

          // Verifica si este movimiento bloquea al jugador humano de ganar.
          if (isWinner(humanPlayer)) {
            board[row][col] = aiPlayer;
            return;
          }

          board[row][col] = '';
        }
      }
    }

    // Si no se encontró un movimiento ganador, realiza un movimiento aleatorio.
    makeRandomMove();
  }


  void makeWinningMove() {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == '') {
          board[row][col] = aiPlayer;

          // Verifica si este movimiento resulta en una victoria para el jugador AI.
          if (isWinner(aiPlayer)) {
            return; // Realiza el movimiento ganador y sale de la función.
          }

          // Deshace el movimiento de simulación.
          board[row][col] = '';
        }
      }
    }

    // Si no se encontró un movimiento ganador, realiza un movimiento aleatorio.
    makeBlockingMove();
  }


  bool isWinner(String player) {
    for (int i = 0; i < numRows; i++) {
      if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
        return true;
      }
    }

    for (int j = 0; j < numCols; j++) {
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

  String difficultyName(){
    switch (dificultad){
      case Difficulty.easy:
        return 'Fácil';
      case Difficulty.medium:
        return 'Medio';
      case Difficulty.hard:
        return 'Difícil';
    }
  }


  void showDialogMessage(String winnerPlayer, bool isDraw){
    if(winnerPlayer == humanPlayer){
      dialogTitle = 'Ganaste!';
      dialogMessage = 'Has ganado a la IA!';

      showAlert();
    }
    else if(winnerPlayer == aiPlayer){
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

  void showDifficultyAlert(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            dialogTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: Column(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  dificultad = Difficulty.easy;
                  resetBoard();
                  notifyListeners();
                  Navigator.pop(context);
                },
                child: const Text('Fácil'),
              ),
              TextButton(
                onPressed: () {
                  dificultad = Difficulty.medium;
                  resetBoard();
                  notifyListeners();
                  Navigator.pop(context);
                },
                child: const Text('Medio'),
              ),
              TextButton(
                onPressed: () {
                  dificultad = Difficulty.hard;
                  resetBoard();
                  notifyListeners();
                  Navigator.pop(context);
                },
                child: const Text('Difícil'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                resetBoard();
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

}