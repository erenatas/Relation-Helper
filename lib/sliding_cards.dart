import 'package:flutter/material.dart';
import 'dart:math' as math;


class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() =>
      pageOffset = pageController.page); //<-- add listener and set state
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height *
            0.55, //<-- set height of the card
        child: PageView(
          controller: pageController,
          children: <Widget>[
            SlidingCard(
              //<-- new widget
              name: 'Neris Baskan',
              date:
              'If you have a problem in your relation, she is the one to solve.',
              assetName: 'neris.jpg',
              offset: pageOffset,
            ),
            SlidingCard(
              name: 'John Doe',
              date: 'Forget this guy, talk with Neris',
              assetName: 'john.jpg',
              offset: pageOffset - 1,
            ),
            SlidingCard(
              name: 'Elizabeth Doe',
              date: 'Forget her, talk with Neris',
              assetName: 'psy1.png',
              offset: pageOffset - 2,
            ),
            SlidingCard(
              name: 'Martin Doe',
              date: 'Forget this guy too, talk with Neris',
              assetName: 'psy2.png',
              offset: pageOffset - 3,
            ),
          ],
        ));
  }
}

class SlidingCard extends StatelessWidget {
  final String name; //<-- title of the event
  final String date; //<-- date of the event
  final String assetName; //<-- name of the image to be displayed
  final double offset;

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));

    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        //<--custom shape
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                'assets/$assetName',
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.none,
                scale: 1.7,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                //<--replace the Container with CardContent
                name: name,
                date: date,
                offset: gauss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;

  const CardContent(
      {Key key,
        @required this.name,
        @required this.date,
        @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(date, style: TextStyle(color: Colors.grey)),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: RaisedButton(
                  color: Colors.redAccent,
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: Text('Talk'),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {},
                ),
              ),
              Spacer(),
              Transform.translate(
                  offset: Offset(32 * offset, 0),
                  child: Text(
                    '\$2 per 5 mins',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )),
              SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
