import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as io;

class CustomCounter extends StatefulWidget {
  const CustomCounter({super.key});

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  late int counter;
  late final double screenWidth;
  late final double screenHeight;
  late final double widgetWidth;
  late final double widgetHeight;
  late int numberOfArtWork;
  String path = '../../assets/to_deploy/number.txt';

  @override
  void initState() {
    counter = 0;
    screenHeight = 700;
    screenWidth = 1290;
    widgetWidth = screenWidth / 5;
    widgetHeight = screenHeight / 12;
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    numberOfArtWork = await _numberOfFile();
    super.didChangeDependencies();
  }

  _numberOfFile() async {
    var file = await io.HttpRequest.getString(path);
    var number = int.parse(file);
    return number;
  }

  void onMinTap() {
    setState(() {
      counter = 1;
    });
  }

  void onDecreaseTap() {
    if (counter - 1 >= 0) {
      setState(() {
        counter = counter - 1;
      });
    }
  }

  void onIncreaseTap() {
    if (counter + 1 <= numberOfArtWork) {
      setState(() {
        counter = counter + 1;
      });
    }
  }

  void onMaxTap() async {
    setState(() {
      counter = numberOfArtWork;
    });
  }

  @override
  Widget build(BuildContext context) {
    double tilesWidth = widgetWidth / 8;

    return SizedBox(
      width: widgetWidth,
      height: widgetHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: const Border(
                top: BorderSide(color: Color.fromARGB(255, 2, 94, 49)),
                bottom: BorderSide(color: Color.fromARGB(255, 2, 94, 49)),
                left: BorderSide(color: Color.fromARGB(255, 2, 94, 49)),
                right: BorderSide(color: Color.fromARGB(255, 2, 94, 49)))),
        child: Row(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                  border: Border(
                      right:
                          BorderSide(color: Color.fromARGB(255, 2, 94, 49)))),
              child: SizedBox(
                width: 2 * tilesWidth,
                height: widgetHeight,
                child: TextButton(
                    onPressed: onMinTap,
                    child: const Text(
                      'MIN',
                      style: TextStyle(
                          color: Color.fromARGB(255, 160, 149, 0),
                          fontWeight: FontWeight.w400),
                    )),
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                  border: Border(
                      right:
                          BorderSide(color: Color.fromARGB(255, 2, 94, 49)))),
              child: SizedBox(
                width: 1.5 * tilesWidth,
                height: widgetHeight,
                child: IconButton(
                    onPressed: onDecreaseTap,
                    icon: Icon(
                      Icons.remove_circle_outline,
                      size: tilesWidth,
                    )),
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                  border: Border(
                      right:
                          BorderSide(color: Color.fromARGB(255, 2, 94, 49)))),
              child: SizedBox(
                width: tilesWidth,
                height: widgetHeight,
                child: Center(
                    child: Text(
                  '$counter',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 50, 123, 136),
                      fontWeight: FontWeight.w400),
                )),
              ),
            ),
            DecoratedBox(
              decoration: const BoxDecoration(
                  border: Border(
                      right:
                          BorderSide(color: Color.fromARGB(255, 2, 94, 49)))),
              child: SizedBox(
                width: 1.5 * tilesWidth,
                height: widgetHeight,
                child: IconButton(
                  onPressed: onIncreaseTap,
                  icon: Icon(Icons.add_circle_outline, size: tilesWidth),
                ),
              ),
            ),
            SizedBox(
                width: 2 * tilesWidth,
                height: widgetHeight,
                child: TextButton(
                    onPressed: onMaxTap,
                    child: const Text(
                      'MAX',
                      style: TextStyle(
                          color: Color.fromARGB(255, 252, 92, 0),
                          fontWeight: FontWeight.w400),
                    )))
          ],
        ),
      ),
    );
  }
}
