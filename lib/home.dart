import 'package:flutter/material.dart';
import 'package:flutter_app_test1/sliding_cards.dart';
import 'package:flutter_app_test1/bottom.dart';
import 'package:flutter_app_test1/tabs.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 8),
                  Header(),
                  Tabs(),
                  SizedBox(height: 40),
                  SizedBox(height: 8),
                  SlidingCardsView(),
                ],
              ),
            ),
            RelationBottomSheet(),
          ],
        ),
      );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        'Relation Solvers',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}