import 'package:flutter/material.dart';

double ballRadius = 7.5;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _angle = 0.0;
  double _oldAngle = 0.0;
  double _angleDelta = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Transform.rotate(
                  angle: _angle,
                  child: Column(
                    children: [
                      Container(
                        width: 700,
                        height: 700,
                        decoration: BoxDecoration(
                          // color: Colors.black,
                          image: DecorationImage(
                            image: AssetImage("assets/images/wheel_back.png"),
                            fit: BoxFit.cover,
                          ),
                          // borderRadius: BorderRadius.circular(30),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            //   Offset centerOfGestureDetector = Offset(
                            // constraints.maxWidth / 2, constraints.maxHeight / 2);
                            /**
                             * using center of positioned element instead to better fit the
                             * mental map of the user rotating object.
                             * (height = container height (30) + container height (30) + container height (200)) / 2
                             */
                            Offset centerOfGestureDetector =
                            Offset(constraints.maxWidth/2, 200);
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onPanStart: (details) {
                                final touchPositionFromCenter =
                                    details.localPosition -
                                        centerOfGestureDetector;
                                _angleDelta = _oldAngle -
                                    touchPositionFromCenter.direction;
                              },
                              onPanEnd: (details) {
                                setState(
                                      () {
                                    _oldAngle = _angle;
                                  },
                                );
                              },
                              onPanUpdate: (details) {
                                final touchPositionFromCenter =
                                    details.localPosition -
                                        centerOfGestureDetector;

                                setState(
                                      () {
                                    _angle = touchPositionFromCenter.direction +
                                        _angleDelta;
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left:0,
                width: 700,
                height: 700,
                child: IgnorePointer(
                  child: Container(
                    width:150,
                    height:150,
                    decoration: BoxDecoration(
                      // color: Colors.black,
                      image: DecorationImage(
                        image: AssetImage("assets/images/wheel_top_new.png"),
                        fit: BoxFit.cover,
                      ),
                      // borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 350,
                left:0,
                child: IgnorePointer(
                  child: Container(
                    width:700,
                    height:500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}