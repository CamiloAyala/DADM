import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stacked/stacked.dart';

import 'package:reto_4/views/bottom_navbar/bottom_navbar_viewmodel.dart';

class BottomNavbarView extends StatelessWidget
{
  final void Function(int)? onChangeIndex;
  final int currentIndex;

  const BottomNavbarView({
    Key? key, 
    required this.onChangeIndex, 
    required this.currentIndex
  }) : super(key: key);

  @override
  Widget build (BuildContext context) 
  {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BottomNavbarViewModel(), 
      builder: (context, BottomNavbarViewModel model, child) => SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            child: GNav(
              backgroundColor: Theme.of(context).colorScheme.surface,
              color: Theme.of(context).colorScheme.primary,
              activeColor: Theme.of(context).colorScheme.background,
              tabBackgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.all(16),
              gap: 8,
              onTabChange: onChangeIndex,
              tabs: const [
                GButton(
                  icon: Icons.sports_esports_outlined,
                  text: 'Jugar',
                ),
                GButton(
                  icon: Icons.smart_toy_outlined,
                  text: 'Dificultad',
                ),
                GButton(
                  icon: Icons.logout_outlined,
                  text: 'Salir',
                ),
              ],
            )
          ),
        ),
      )
    );
  }

}
