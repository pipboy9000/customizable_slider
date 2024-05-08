library customizable_slider;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomizableSlider extends StatefulWidget {
  final List<Widget> pages;
  final List<Color>? backgroundColors;
  final Widget Function(double anim, List<Color> backgroundColors, int index, int currPage)? anim;
  const CustomizableSlider({super.key, required this.pages, this.backgroundColors, this.anim});

  @override
  State<CustomizableSlider> createState() => _CustomizableSliderState();
}

class _CustomizableSliderState extends State<CustomizableSlider> with SingleTickerProviderStateMixin {
  late final Ticker ticker;
  int currPage = 0;
  double pos = 0;
  double lastPos = 0;
  bool snap = false;
  bool? direction;
  List<Color> backgroundColors = [];
  late double width;

  @override
  void initState() {
    super.initState();

    //populate background colors
    if (widget.backgroundColors != null) {
      assert(widget.backgroundColors!.length == widget.pages.length);
      backgroundColors = widget.backgroundColors!;
    } else {
      for (int i = 0; i < widget.pages.length; i++) {
        backgroundColors.add(Colors.transparent);
      }
    }

    ticker = createTicker((elapsed) {
      direction = lastPos == pos ? null : lastPos < pos;
      lastPos = pos;
      if (snap) {
        if (pos != currPage) {
          double dist = (pos - currPage).abs();

          //animation speed
          if (dist < 1) {
            pos += (currPage - pos) / 10;
          } else {
            pos < currPage ? pos += 0.1 : pos -= 0.1;
          }

          //snap
          if (dist < 0.001) {
            pos = currPage.toDouble();
            snap = false;
          }
        }
      }

      setState(() {});
    });
    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  gotoPage(int index) {
    setState(() {
      snap = true;
      currPage = index.clamp(0, widget.pages.length - 1);
    });
  }

  onDrag(DragUpdateDetails details) {
    pos -= details.delta.dx / width;
    pos = clampDouble(pos, 0, widget.pages.length as double);
    setState(() {});
  }

  onDragStart(DragStartDetails details) {
    snap = false;
    pos = currPage as double;
    setState(() {});
  }

  onDragEnd(DragEndDetails details) {
    if (direction != null) {
      if (direction == true && currPage < widget.pages.length - 1) {
        currPage++;
      } else if (direction == false && currPage > 0) {
        currPage--;
      }
    } else {
      currPage = pos.round().clamp(0, widget.pages.length - 1);
    }
    snap = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      width = constraints.constrainWidth();

      return Container(
        width: width,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: GestureDetector(
          onHorizontalDragUpdate: onDrag,
          onHorizontalDragStart: onDragStart,
          onHorizontalDragEnd: onDragEnd,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: backgroundColors[currPage],
              ),
              //pages
              for (int i = 0; i < widget.pages.length; i++)
                Center(
                  child: Transform.translate(
                    offset: Offset(
                      -pos * width + (i * width),
                      0,
                    ),
                    child: widget.pages[i],
                  ),
                ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.pages.length; i++)
                      Builder(
                        builder: (context) {
                          double distFromIdx = (pos - i).abs();
                          double normalized = 0;
                          if (distFromIdx < 1) {
                            normalized = 1 - distFromIdx;
                          }

                          return Flexible(
                            flex: 1,
                            child: GestureDetector(onTap: () {
                              gotoPage(i);
                            }, child: Builder(
                              builder: (context) {
                                if (widget.anim != null) {
                                  return widget.anim!(normalized, backgroundColors, i, currPage);
                                }
                                return defaultAnim(normalized, backgroundColors, i, currPage);
                              },
                            )),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget defaultAnim(double anim, List<Color> backgroundColors, int pageIdx, int currPage) {
  return Container(
    decoration: const BoxDecoration(color: Color.fromARGB(0, 0, 0, 0), shape: BoxShape.circle),
    width: 80,
    height: 80,
    child: Center(
      child: Center(
        child: Opacity(
          opacity: 1,
          child: Container(
            width: 10 + anim * 20,
            height: 10,
            decoration: BoxDecoration(
              color: Color.lerp(
                  backgroundColors[pageIdx], Colors.white, clampDouble(anim - (currPage == pageIdx ? 0 : 0.8), 0, 1)),
              border: Border.all(
                color: const Color.fromARGB(86, 255, 255, 255),
                width: 5,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    ),
  );
}
