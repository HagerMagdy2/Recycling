import 'package:firstly/constants.dart';
import 'package:firstly/presintations/widgets/start_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StartScreen extends StatelessWidget {
  StartScreen({super.key});
  static String id = 'StartScreen';
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          children: [Page2(), Page3(), Page4()],
        ),
        Container(
            alignment: Alignment(0, 0.95),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                  activeDotColor: kMainColor, // Color of the active dot
                  dotColor: const Color.fromARGB(255, 126, 125, 125)),
            )),
      ],
    ));
  }
}
