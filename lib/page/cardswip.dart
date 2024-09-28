import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class Cardswip extends StatefulWidget {
  const Cardswip({Key? key});

  @override
  State<Cardswip> createState() => _CardswipState();
}

class _CardswipState extends State<Cardswip> {
  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      child: Image.asset('assets/images/img.jpg'),
    ),
    Container(
      alignment: Alignment.center,
      child: Image.asset('assets/images/img2.jpg'),
    ),
    Container(
      alignment: Alignment.center,
      child: Image.asset('assets/images/img2.jpg'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                4,
                (index) {
                  return AspectRatio(
                    aspectRatio: 0.6,
                    child: CardSwiper(
                      padding: const EdgeInsets.all(1),
                      numberOfCardsDisplayed: 1,
                      cardsCount: cards.length,
                      cardBuilder: (context, index, percentThresholdX,
                              percentThresholdY) =>
                          cards[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
