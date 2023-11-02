// Package imports:
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:reto_5/views/pages/home_page/home_page_view.dart';
import 'package:reto_5/views/pages/tic_tac_toe_page/tic_tac_toe_view.dart';

class HomeViewModel extends BaseViewModel {

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }

  final List<Widget> pages = [
    const HomePageView(),
    const TicTacToeView(title: 'Reto 6'),
  ];
}