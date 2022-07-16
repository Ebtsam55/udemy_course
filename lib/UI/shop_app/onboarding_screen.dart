import 'package:flutter/material.dart';
import 'package:news_app/UI/shop_app/login_screen.dart';
import 'package:news_app/network/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String image;
  String title;
  String description;

  BoardingModel(
      {required this.title, required this.image, required this.description});
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  List<BoardingModel> boardings = [
    BoardingModel(
        title: "Onboarding Title 1 ",
        image: "assets/images/1.jpg",
        description: "Onboarding Description 1"),
    BoardingModel(
        title: "Onboarding Title 2 ",
        image: "assets/images/2.jpg",
        description: "Onboarding Description 2"),
    BoardingModel(
        title: "Onboarding Title 3 ",
        image: "assets/images/3.jpg",
        description: "Onboarding Description 3")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => _navigateToLogin(context),
              child: const Text(
                "Skip",
                style: TextStyle(fontSize: 18, color: Colors.deepOrange),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemBuilder: (ctx, index) =>
                    _buildOnboardingItem(boardings[index]),
                itemCount: 3,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Theme.of(context).primaryColor),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (controller.page == boardings.length - 1) {
                      _navigateToLogin(context);
                    }
                    controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  child: const Icon(Icons.arrow_forward),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingItem(BoardingModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
              child: Image(
            image: AssetImage(item.image),
            fit: BoxFit.cover,
          )),
        ),
        Text(
          item.title,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          item.description,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  void _navigateToLogin(BuildContext context) {
    CacheHelper.putData(key: 'onboarding', value: true).then((value) => {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()))
        });
  }
}
