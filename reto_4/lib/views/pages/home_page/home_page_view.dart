import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Text(
            'RETO 4',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      )
    ]);
  }
}
