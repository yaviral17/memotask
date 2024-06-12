import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memotask/Screens/Home/mcq_list/view_models/mcq_screen_view_model.dart';
import 'package:memotask/Screens/Home/mcq_list/views/mcq_screen_view.dart';
import 'package:memotask/Screens/Home/profile/views/profile_view.dart';
import 'package:memotask/Screens/Home/streak/views/streak_screen_view.dart';
import 'package:memotask/components/app_bar.dart';
import 'package:provider/provider.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    MCQViewModel mcqViewModel = Provider.of<MCQViewModel>(context);
    // MCQViewModel mcqViewModel = Provider.of<MCQViewModel>(context);
    // MCQViewModel mcqViewModel = Provider.of<MCQViewModel>(context);
    List<String> titles = ['MCQs', 'Streaks', 'Profile'];
    return Scaffold(
      appBar: currentIndex != titles.length - 1
          ? AppBarView(
              title: titles[currentIndex],
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            )
          : null,
      body: PageView(
        controller: pageController,
        onPageChanged: (value) => setState(() {
          currentIndex = value;
        }),
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          // Add your pages here
          MCQScreen(
            viewModel: mcqViewModel,
          ),
          StreakScreen(),
          const ProfileView(),
        ],
      ),

      // Add your bottom navigation bar here
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
            pageController.jumpToPage(value);
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: currentIndex == 0 ? Icon(Iconsax.book_1) : Icon(Iconsax.book),
            label: 'MCQs',
          ),
          BottomNavigationBarItem(
            icon: currentIndex == 1
                ? Icon(Icons.local_fire_department)
                : Icon(Icons.local_fire_department_outlined),
            label: 'Streaks',
          ),
          BottomNavigationBarItem(
            icon: currentIndex == 2
                ? Icon(Icons.person)
                : Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
