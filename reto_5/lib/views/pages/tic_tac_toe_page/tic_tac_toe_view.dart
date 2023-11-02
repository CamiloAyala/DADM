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
    Orientation orientation = MediaQuery.of(context).orientation;
    myWidget(
        {required MainAxisAlignment mainAxisAlignment,
        required List<Widget> children}) {
      return orientation == Orientation.portrait
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            );
    }

    print(orientation == Orientation.landscape);
    return ViewModelBuilder<TicTacToeViewModel>.reactive(
        viewModelBuilder: () => TicTacToeViewModel(context: context),
        builder: (context, model, child) => myWidget(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  orientation == Orientation.portrait
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Text(
                            'Tic Tac Toe',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        )
                      : const SizedBox(height: 0),
                  SizedBox(
                    width: orientation == Orientation.portrait
                        ? double.infinity
                        : MediaQuery.of(context).size.width * 0.7,
                    height: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.5
                        : MediaQuery.of(context).size.height * 0.6,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(20.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio:
                              orientation == Orientation.portrait ? 1 : 3,
                          crossAxisSpacing: 25.0,
                          mainAxisSpacing: 25.0),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        int row = index ~/ 3;
                        int col = index % 3;

                        return GestureDetector(
                          onTap: () => model.play(row, col),
                          child: Container(
                            width:
                                orientation == Orientation.portrait ? 100 : 10,
                            height:
                                orientation == Orientation.portrait ? 100 : 10,
                            decoration: BoxDecoration(
                                color: model.colorCell(context, row, col),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    orientation == Orientation.portrait
                                        ? 25.0
                                        : 10.0))),
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
                  ),
                  const SizedBox(height: 35),
                  Column(
                    children: [
                      SizedBox(
                          height: 30,
                          child: Text(
                            model.dificultad == Difficulty.easy
                                ? 'Fácil'
                                : model.dificultad == Difficulty.medium
                                    ? 'Medio'
                                    : 'Difícil',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.smart_toy_outlined),
                        onPressed: model.showDifficultyAlert,
                        label: const Text('Cambiar dificultad'),
                      ),
                    ],
                  )
                ]));
  }
}
