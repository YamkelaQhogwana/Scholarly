import 'package:flutter/material.dart';
import 'package:scholarly/screens/home.dart';

import '../constants/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: const [
                OnboardingScreen(
                  title: 'Get Your S@%# Together',
                  description:
                      'An all-in-one tool to help you stay organised and on top of your academic and personal life.',
                  image: AssetImage('assets/images/onboarding-img1.png'),
                ),
                OnboardingScreen(
                  title: 'Never Miss a Deadline',
                  description:
                      'Keep track of all your assignments, exams, and other important deadlines in one place, so you never miss a due date again.',
                  image: AssetImage('assets/images/onboarding-img2.png'),
                ),
                OnboardingScreen(
                  title: 'Maximise Your Productivity',
                  description:
                      'From setting daily goals to maintaining your mental health, our tools will help you make the most of your time and stay motivated.',
                  image: AssetImage('assets/images/onboarding-img3.png'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity, // Take full width of the screen
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.kPrimary400),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Get Started'),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      indicators.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == i ? AppColors.kPrimary400 : AppColors.kDarkGray,
          ),
        ),
      );
    }
    return indicators;
  }
}

class OnboardingScreen extends StatelessWidget {
  final String title;
  final String description;
  final AssetImage image;

  const OnboardingScreen({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: image,
            height: 300,
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimary400),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style:
                    const TextStyle(fontSize: 16, color: AppColors.kMainText),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
