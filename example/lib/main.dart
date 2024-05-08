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
        body: Column(
      children: [
        SizedBox(
          width: 400,
          height: 300,
          child: CustomizableSlider(
            pages: pages,
            backgroundColors: backgroundColors,
          ),
        ),
        SizedBox(
          width: 600,
          height: 300,
          child: CustomizableSlider(
            pages: pages,
            anim: (anim, backgroundColors, index, currPage) => Container(
              width: 50,
              height: 50,
              child: Center(
                child: Container(
                  width: 20,
                  height: 20 + 20 * anim,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
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
