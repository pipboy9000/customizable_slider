import 'dart:math';

import 'package:customizable_slider/customizable_slider.dart';
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
              backgroundColors: backgroundColors,
            ),
          ),
          SizedBox(
            height: 200,
            child: CustomizableSlider(
              pages: pages,
              anim: (anim, backgroundColors, index, currPage) => SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 20,
                    height: index == currPage ? 40 : 20,
                    color: Colors.red,
                  ),
                ),
              ),
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
                Colors.grey.shade200
              ],
              pages: pages,
              anim: (anim, backgroundColors, index, currPage) => SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: Container(
                    // duration: const Duration(milliseconds: 300),
                    width: 20,
                    height: 20 + anim * 20,
                    decoration: BoxDecoration(
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
                Colors.yellow.shade600,
                Colors.yellow.shade500,
                Colors.yellow.shade400,
                Colors.yellow.shade300,
                Colors.yellow.shade200
              ],
              pages: pages,
              anim: (anim, backgroundColors, index, currPage) => SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: Transform.rotate(
                    angle: anim * pi / 2,
                    child: Container(
                      width: 15,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

List<Widget> pages = [
  const Text("Page 0"),
  const Text("Page 1"),
  const Text("Page 2"),
  const Text("Page 3"),
  const Text("Page 4")
];
List<Color> backgroundColors = [
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.red,
  Colors.purple,
];
