import 'package:clean_calendar/clean_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memotask/Firestore/firestore_collections_and_documents.dart';
import 'package:memotask/Models/streakModel.dart' as streakModel;

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  Future<streakModel.Streak?> getStreakDates() async {
    streakModel.Streak? strk = await FirestoreRefrence.getSreak(
        FirebaseAuth.instance.currentUser!.uid);
    return strk;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        FutureBuilder(
          future: getStreakDates(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('No Streaks'),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            List<DateTime> dates = [];
            if (snapshot.data != null) {
              dates = snapshot.data!.streakDates;
            }
            return CleanCalendar(
              streakDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBackgroundColor: Colors.green,
                  datesBorderColor: Colors.green,
                  datesBorderRadius: 10,
                  datesTextColor: Colors.white,
                  datesTextStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              currentDateOfCalendar: DateTime.now(),
              generalDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBackgroundColor: Colors.transparent,
                  datesBorderColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  datesBorderRadius: 12,
                  datesTextColor: Theme.of(context).colorScheme.onPrimary,
                  datesTextStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              datesForStreaks: dates,
            );
          },
        ),
        // CleanCalendar(
        //   streakDatesProperties: DatesProperties(
        //     datesDecoration: DatesDecoration(
        //       datesBackgroundColor: Colors.green,
        //       datesBorderColor: Colors.green,
        //       datesBorderRadius: 10,
        //       datesTextColor: Colors.white,
        //       datesTextStyle: Theme.of(context).textTheme.bodyText1,
        //     ),
        //   ),
        //   currentDateOfCalendar: DateTime.now(),
        //   generalDatesProperties: DatesProperties(
        //     datesDecoration: DatesDecoration(
        //       datesBackgroundColor: Colors.transparent,
        //       datesBorderColor:
        //           Theme.of(context).colorScheme.secondaryContainer,
        //       datesBorderRadius: 12,
        //       datesTextColor: Theme.of(context).colorScheme.onPrimary,
        //       datesTextStyle: Theme.of(context).textTheme.bodyText1,
        //     ),
        //   ),
        //   datesForStreaks: [
        //     DateTime.now().subtract(Duration(days: 1)),
        //     DateTime.now().subtract(Duration(days: 2)),
        //     DateTime.now().subtract(Duration(days: 3)),
        //     DateTime.now().subtract(Duration(days: 4)),
        //     DateTime.now().subtract(Duration(days: 5)),
        //     DateTime.now().subtract(Duration(days: 6)),
        //     DateTime.now().subtract(Duration(days: 9)),
        //     DateTime.now().subtract(Duration(days: 10)),
        //   ],
        // ),
      ],
    ));
  }
}
