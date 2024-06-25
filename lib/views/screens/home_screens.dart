import 'dart:math';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Alignment _alignment1 = Alignment.centerLeft;
  Alignment _alignment2 = Alignment.centerRight;
  final Random _random = Random();

  bool isBig = true;
  bool _isStyle = true;
  bool _isVisible = true;
  bool _isFlapping = false;
  bool _isMoved = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeAlignment() {
    double x1 = _random.nextDouble() * 2 - 1;
    double y1 = _random.nextDouble() * 2 - 1;
    double x2 = _random.nextDouble() * 2 - 1;
    double y2 = _random.nextDouble() * 2 - 1;

    setState(() {
      _alignment1 = Alignment(x1, y1);
      _alignment2 = Alignment(x2, y2);
      isBig = !isBig;
      _isStyle = !_isStyle;
      _isVisible = !_isVisible;
      _isFlapping = !_isFlapping;
      _isMoved = !_isMoved;
      if (_isFlapping) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      duration: Duration(seconds: 3),
      data: isBig ? ThemeData.light() : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Birds Animation"),
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                AnimatedAlign(
                  alignment: _alignment1,
                  duration: const Duration(seconds: 1),
                  child: _buildBird(Colors.blue),
                ),
                AnimatedAlign(
                  alignment: _alignment2,
                  duration: const Duration(seconds: 1),
                  child: _buildBird(Colors.green),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isBig = !isBig;
                  });
                },
                child: AnimatedPositionedDirectional(
                  duration: const Duration(seconds: 1),
                  start: _isMoved ? 50.0 : 150.0,
                  child: AnimatedPhysicalModel(
                    borderRadius: BorderRadius.circular(50),
                    duration: const Duration(seconds: 1),
                    color: isBig ? Colors.red : Colors.white,
                    elevation: 20,
                    shadowColor: Colors.black,
                    shape: BoxShape.rectangle,
                    child: AnimatedContainer(
                      height: isBig ? 300 : 100,
                      width: isBig ? 400 : 200,
                      duration: const Duration(seconds: 1),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(seconds: 1),
                          style: _isStyle
                              ? const TextStyle(
                              fontSize: 50, color: Colors.white)
                              : const TextStyle(
                              fontSize: 20, color: Colors.black),
                          child: const Text("YouTube"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("test"),
                ],
              ),
              secondChild: Container(
                color: Colors.teal,
                height: 200,
                width: 100,
              ),
              crossFadeState:
              isBig ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(seconds: 1),
            ),
            const SizedBox(height: 50.0, width: 50),
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: isBig
                  ? Container(
                height: 100,
                color: Colors.amber,
              )
                  : Text("Second"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _changeAlignment,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2.0 * pi,
                child: Icon(_isFlapping ? Icons.stop : Icons.play_arrow),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBird(Color color) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: _isFlapping
          ? Icon(Icons.airplanemode_active,
          key: const ValueKey(1), color: color, size: 60)
          : Icon(Icons.airplanemode_inactive,
          key: const ValueKey(2), color: color, size: 60),
    );
  }
}
