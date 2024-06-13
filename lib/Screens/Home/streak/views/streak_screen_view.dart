import 'dart:async';

import 'package:clean_calendar/clean_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memotask/Firestore/firestore_collections_and_documents.dart';
import 'package:memotask/Models/streakModel.dart' as streakModel;
import 'package:memotask/Screens/Authentication/login/view_models/login_view_model.dart';
import 'package:memotask/Utils/app_size.dart';
import 'package:memotask/Utils/const_colors.dart';

class StreakScreen extends StatefulWidget {
  StreakScreen({
    super.key,
    required this.loginViewModel,
  });
  LoginViewModel loginViewModel = LoginViewModel();

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  Future<streakModel.Streak?> getStreakDates() async {
    streakModel.Streak? strk = await FirestoreRefrence.getSreak(
        FirebaseAuth.instance.currentUser!.uid);
    return strk;
  }

  String streakEndsIn = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.loginViewModel.getLoggedInUser(forced: true);
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   DateTime timeDiff = DateTime.now().difference(
    //       widget.loginViewModel.loggedInUser!.streak!.lastActivity!);

    //   setState(() {
    //     streakEndsIn =
    //         'Streak ending in ${DateTime.now().difference(widget.loginViewModel.loggedInUser!.streak!.lastActivity).inDays}: ${DateTime.now().difference(widget.loginViewModel.loggedInUser!.streak!.lastActivity).inHours.remainder(24)}: ${DateTime.now().difference(widget.loginViewModel.loggedInUser!.streak!.lastActivity).inMinutes.remainder(60)}: ${DateTime.now().difference(widget.loginViewModel.loggedInUser!.streak!.lastActivity).inSeconds.remainder(60)}';
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        // Add your widgets here

        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Current Streak 🔥',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: AppSizes.spacingSmall,
                  ),
                  Text(
                    widget.loginViewModel.loggedInUser != null
                        ? widget
                            .loginViewModel.loggedInUser!.streak!.streakLength
                            .toString()
                        : '0',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              // Add your widgets here
              Column(
                children: <Widget>[
                  Text(
                    'Highest streak 🔥',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: AppSizes.spacingSmall,
                  ),
                  Text(
                    widget.loginViewModel.loggedInUser != null
                        ? widget
                            .loginViewModel.loggedInUser!.streak!.streakLength
                            .toString()
                        : '0',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ],
          ),
        ),

        //  Streak ending progress bar
        // Container(
        //   // margin: const EdgeInsets.symmetric(horizontal: AppSizes.marginMedium),
        //   height: AppSizes.getDeviceHeight(context) * 0.05,
        //   clipBehavior: Clip.antiAlias,
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).colorScheme.background,
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border.all(
        //       color: Theme.of(context).colorScheme.secondaryContainer,
        //     ),
        //   ),
        //   child: Stack(
        //     children: <Widget>[
        //       Align(
        //         alignment: Alignment.centerLeft,
        //         child: AnimatedContainer(
        //           duration: const Duration(milliseconds: 500),
        //           width: AppSizes.getDeviceWidth(context) *
        //               (DateTime.now()
        //                       .difference(widget.loginViewModel.loggedInUser!
        //                           .streak!.lastActivity)
        //                       .inSeconds /
        //                   86400),
        //           decoration: BoxDecoration(
        //             color: AppColors.warning,
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //         ),
        //       ),
        //       Align(
        //         alignment: Alignment.center,
        //         child: Text(
        //           streakEndsIn,
        //           style: Theme.of(context).textTheme.bodyText1,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Streak  Calendar

        widget.loginViewModel.loggedInUser != null
            ? CleanCalendar(
                streakDatesProperties: DatesProperties(
                  datesDecoration: DatesDecoration(
                    datesBackgroundColor: AppColors.warning,
                    datesTextColor: Theme.of(context).colorScheme.onPrimary,
                    datesTextStyle: Theme.of(context).textTheme.bodyText1,
                    // datesBackgroundColor: Colors.green,
                    // datesBorderColor: Colors.green,
                    // datesBorderRadius: 10,
                    // datesTextColor: Colors.white,
                    // datesTextStyle:
                    //     Theme.of(context).textTheme.bodyText1!.copyWith(
                    //           color: Colors.white,
                    //         ),
                  ),
                ),
                currentDateProperties: DatesProperties(
                  datesDecoration: DatesDecoration(
                    datesBorderColor: Theme.of(context).colorScheme.onPrimary,
                    datesTextColor: Theme.of(context).colorScheme.onPrimary,
                    datesTextStyle: Theme.of(context).textTheme.bodyText1,
                    // datesBackgroundColor: Colors.green,
                    // datesBorderColor: Colors.green,
                    // datesBorderRadius: 10,
                    // datesTextColor: Colors.white,
                    // datesTextStyle:
                    //     Theme.of(context).textTheme.bodyText1!.copyWith(
                    //           color: Colors.white,
                    //         ),
                  ),
                ),
                currentDateOfCalendar: DateTime.now(),
                // generalDatesProperties: DatesProperties(
                //   datesDecoration: DatesDecoration(
                //     datesBackgroundColor: Colors.transparent,
                //     datesBorderColor:
                //         Theme.of(context).colorScheme.secondaryContainer,
                //     datesBorderRadius: 12,
                //     datesTextColor: Theme.of(context).colorScheme.secondary,
                //     datesTextStyle: Theme.of(context).textTheme.bodyText1,
                //   ),
                // ),
                datesForStreaks:
                    widget.loginViewModel.loggedInUser!.streak!.streakDates,
              )
            : const CircularProgressIndicator(),
      ],
    ));
  }
}
