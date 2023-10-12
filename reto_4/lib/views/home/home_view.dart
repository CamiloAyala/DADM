import 'package:flutter/material.dart';
import 'package:reto_4/views/bottom_navbar/bottom_navbar_view.dart';
import 'package:stacked/stacked.dart';
import 'package:reto_4/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, HomeViewModel model, Widget? child) => SafeArea(
        child: Scaffold(

        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,

        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            title,
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),

        body: SafeArea(child: SingleChildScrollView(child: model.pages[model.currentIndex])),

        bottomNavigationBar: BottomNavbarView(
          onChangeIndex: model.changeIndex,
          currentIndex: model.currentIndex,
        ),
      ),
    ),
     viewModelBuilder: () => HomeViewModel(),
    );
  }
}