import 'package:flutter/material.dart';

class MovingBall extends StatefulWidget {
  @override
  _MovingBallState createState() => _MovingBallState();
}

class _MovingBallState extends State<MovingBall> with TickerProviderStateMixin {
  late AnimationController _controller;
  double _position = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _controller.addListener(() {
      setState(() {
        _position = _controller.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Positioned(
                  top: 150 * _position,
                  left: width / 2 - 25,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
