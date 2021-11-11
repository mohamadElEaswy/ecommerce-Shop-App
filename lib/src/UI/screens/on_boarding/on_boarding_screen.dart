import 'package:flutter/material.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/UI/screens/login/login_screen.dart';
import 'package:shop2/src/core/models/on_boarding_model.dart';
import 'package:shop2/src/core/route/const_route_functions.dart';
import 'package:shop2/src/data/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const String img = 'assets/images/boarding_image/canvas.png';
List<BoardingModel> boarding = [
  BoardingModel(title: 'title', body: 'body', image: img),
  BoardingModel(title: 'title1', body: 'body', image: img),
  BoardingModel(title: 'title2', body: 'body', image: img),
];
PageController pageController = PageController();
bool isLast = false;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(0.0),
            ),
            onPressed: () {
              submit(context: context);
            },
            child: const Text(
              'SKIP',
              style: TextStyle(color: defaultColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (BuildContext context, index) => BoardingItem(
                  boarding: boarding[index],
                ),
                controller: pageController,
                itemCount: boarding.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  count: boarding.length,
                  controller: pageController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (isLast) {
                      submit(context: context);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}

class BoardingItem extends StatelessWidget {
  const BoardingItem({Key? key, required this.boarding}) : super(key: key);
  final BoardingModel boarding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage(boarding.image),
          ),
        ),
        const SizedBox(height: 30.0),
        Text(
          boarding.title,
          style: const TextStyle(fontSize: 24.0, color: Colors.black),
        ),
        const SizedBox(height: 30.0),
        Text(boarding.body),
        const SizedBox(height: 30.0),
      ],
    );
  }
}

// check and navigate from on boarding screen
//if it's first once to open the app

void submit({required BuildContext context}) {
  CacheHelper.saveData(key: 'isFirst', value: true).then((value) {
    if (value) {
      CacheHelper.getData(key: 'isFirst');
      navigateAndRemove(
        context: context,
        newRouteName: LogInScreen.routeName,
      );
    }
  });
}