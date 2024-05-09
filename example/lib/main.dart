import 'dart:math';
import 'dart:ui';

import 'package:customizable_slider/customizable_slider.dart';
import 'package:example/moving_ball.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Customizable Slider Example',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CustomizableSlider(
                pages: pages,
              ),
            ),
            SizedBox(
              height: 200,
              child: CustomizableSlider(
                pages: pages,
                backgroundColors: const [
                  Colors.green,
                  Colors.cyan,
                  Colors.brown,
                  Colors.yellow,
                  Colors.red,
                ],
                buttonBuilder: (anim, backgroundColors, index, currPage) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        width: 25 + (currPage == index ? 20 * anim : 0),
                        height: 25 + (currPage == index ? 20 * anim : 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.lerp(backgroundColors[index], Colors.white, anim),
                          border: Border.all(color: const Color.fromARGB(186, 255, 255, 255), width: 3),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 200,
              child: CustomizableSlider(
                backgroundColors: [
                  Colors.grey.shade600,
                  Colors.grey.shade500,
                  Colors.grey.shade400,
                  Colors.grey.shade300,
                ],
                pages: pages2,
                buttonBuilder: (anim, backgroundColors, index, currPage) => SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Container(
                      // duration: const Duration(milliseconds: 50),
                      width: 20,
                      height: 20 + anim * 20,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: index == currPage ? 5 : 3,
                            color: index == currPage
                                ? const Color.fromARGB(221, 22, 22, 22)
                                : const Color.fromARGB(96, 26, 26, 26),
                          ),
                          color: index == currPage ? Colors.white : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: CustomizableSlider(
                backgroundColors: [
                  Colors.yellow.shade900,
                  Colors.yellow.shade800,
                  Colors.yellow.shade700,
                  Colors.yellow.shade600,
                  Colors.yellow.shade500
                ],
                pages: pages,
                buttonBuilder: (anim, backgroundColors, index, currPage) => Container(
                  width: 50,
                  height: 50,
                  color: Colors.transparent, //to register clicks around the button
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 140),
                  child: Center(
                    child: Transform.rotate(
                      origin: const Offset(0, -10),
                      angle: anim * pi / 4 - 2,
                      child: Container(
                        width: 10,
                        height: 30,
                        decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 400,
              width: 600,
              child: CustomizableSlider(
                backgroundColors: const [
                  Color.fromARGB(255, 45, 45, 45),
                  Color.fromARGB(255, 74, 74, 74),
                  Color.fromARGB(255, 84, 84, 84),
                  Color.fromARGB(255, 123, 123, 123),
                ],
                pages: const [
                  Icon(
                    Icons.casino_rounded,
                    color: Colors.white,
                    size: 112,
                  ),
                  Icon(
                    Icons.yard_rounded,
                    color: Colors.white,
                    size: 112,
                  ),
                  Icon(
                    Icons.wine_bar,
                    color: Colors.white,
                    size: 112,
                  ),
                  Icon(
                    Icons.whatshot_rounded,
                    color: Colors.white,
                    size: 112,
                  ),
                ],
                buttonBuilder: (anim, backgroundColors, index, currPage) {
                  late Color btnColor;

                  switch (index) {
                    case 0:
                      btnColor = Color.fromARGB(255, 255, 35, 138);
                      break;
                    case 1:
                      btnColor = Color.fromARGB(255, 105, 218, 255);
                      break;
                    case 2:
                      btnColor = Color.fromARGB(255, 86, 255, 125);
                      break;
                    case 3:
                      btnColor = Color.fromARGB(255, 244, 255, 86);
                      break;
                  }
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.transparent, //to register clicks around the button
                    // margin: const EdgeInsets.fromLTRB(0, 0, 0, 140),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12 + anim * 24,
                        transformAlignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.lerp(Color.fromARGB(199, 0, 0, 0), btnColor, anim),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: btnColor.withAlpha((anim * 150).toInt()),
                                blurRadius: 10,
                                spreadRadius: anim * 5),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> pages = const [Text("Page 0"), Text("Page 1"), Text("Page 2"), Text("Page 3"), Text("Page 4")];
List<Widget> pages2 = [
  Container(
    color: Colors.lightBlueAccent.shade400,
    child: const Center(
      child: Text("Full size widget"),
    ),
  ),
  const Icon(
    Icons.access_time_rounded,
    size: 50,
    color: Colors.white,
  ),
  const Icon(
    Icons.home_rounded,
    size: 50,
    color: Colors.white,
  ),
  MovingBall(),
];
List<Color> backgroundColors = [
  Colors.blueAccent,
  Colors.cyan.shade300,
  Colors.green,
  Colors.orange,
  Colors.red,
];
