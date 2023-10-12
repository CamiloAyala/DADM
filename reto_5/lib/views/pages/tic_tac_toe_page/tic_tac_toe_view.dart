import 'package:flutter/material.dart';
import 'package:reto_5/utils/constants.dart';
import 'package:stacked/stacked.dart';

import 'package:reto_5/views/pages/tic_tac_toe_page/tic_tac_toe_viewmodel.dart';

class TicTacToeView extends StatefulWidget {
  const TicTacToeView({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TicTacToeView> createState() => _TicTacToeViewState();
}

class _TicTacToeViewState extends State<TicTacToeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TicTacToeViewModel>.reactive(
      viewModelBuilder: () => TicTacToeViewModel(context: context),
      builder: (context, model, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                'Tic Tac Toe',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            GridView.builder(
              padding: const EdgeInsets.all(20.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 25.0,
                  mainAxisSpacing: 25.0),
              itemCount: 9,
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;

                return GestureDetector(
                  onTap: () => model.play(row, col),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: model.colorCell(context, row, col),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0))),
                    child: Center(
                      child: model.board[row][col] == 'X'
                        ? Image.asset('assets/X_icon.png')
                        : model.board[row][col] == 'O'
                          ? Image.asset('assets/O_icon.png')
                          : null,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 35),
            SizedBox(
              height: 30, 
              child: Text(
                  model.dificultad == Difficulty.easy ? 'Fácil' : model.dificultad == Difficulty.medium ? 'Medio' : 'Difícil',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.smart_toy_outlined),
              onPressed: model.showDifficultyAlert,
              label: const Text('Cambiar dificultad'),
            ),
          ]),
    );
  }
}
