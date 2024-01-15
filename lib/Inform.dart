import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(body: CarouselSliderPage()),
  ));
}

class CarouselSliderPage extends StatefulWidget {
  const CarouselSliderPage({super.key});

  @override
  State<CarouselSliderPage> createState() => _CarouselSliderPageState();
}

class _CarouselSliderPageState extends State<CarouselSliderPage> {
  final List<Map<String, String>> _items = [
    {
      "image": "assets/image1.png",
      "text": "이미지 1에 대한 설명"
    },
    {
      "image": "assets/image2.png",
      "text": "이미지 2에 대한 설명"
    },
    {
      "image": "assets/image3.png",
      "text": "이미지 3에 대한 설명"
    },
    {
      "image": "assets/image4.png",
      "text": "이미지 4에 대한 설명"
    }
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              height: 600.0,
              viewportFraction: 1,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: _items.map((Map<String, String> item) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        item["image"]!,
                        fit: BoxFit.contain,
                      ),
                      Text(item["text"]!)
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _items.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    carouselController.animateToPage(entry.key);
                  },
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 133, 133, 133)
                          .withOpacity(currentIndex == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}