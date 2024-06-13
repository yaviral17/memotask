import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memotask/Models/mcqModel.dart';
import 'package:memotask/Models/streakModel.dart';
import 'package:memotask/Models/usermodel.dart';

class FirestoreRefrence {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static CollectionReference questionCollection(String uid) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('questions');

  // set user for the first time
  static Future<void> setUser(UserModel user) async {
    log('Setting user in firestore');
    await userCollection.doc(user.uid).set(user.toJson());
  }

  // get user by uid
  static Future<UserModel> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await userCollection.doc(uid).get();
    return UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  }

  // update user
  static Future<void> updateUser(UserModel user) async {
    await userCollection.doc(user.uid).update(user.toJson());
  }

  // Post Question Every time user answers a question or skips
  static Future<void> postQuestion(String uid, Question question) async {
    await questionCollection(uid).doc(question.id).set(question.toJson());
  }

  static Future<Streak?> getSreak(String uid) async {
    await userCollection.doc(uid).get().then((value) {
      if (value.data() == null) {
        return null;
      }
      Streak obj = Streak.fromJson(value.data() as Map<String, dynamic>);
      return obj.streakDates;
    });
    return null;
  }

  static Future<void> streakIncrement(String uid, Streak streak) async {
    // check if last  activity has datetime of today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = streak.lastActivity;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);

    if (aDate == today) {
      log("Streak already incremented");
      return;
    }

    if (streak.lastActivity.difference(now).inHours > 24) {
      streak.longestStreak =
          math.max(streak.longestStreak, streak.streakLength);
      streak.streakLength = 0;
      streak.streakDates.add(now);
      streak.lastActivity = now;
      streak.startDate = now;
    } else {
      int countStreak = 0;
      for (int i = streak.streakDates.length - 1; i >= 1; i--) {
        if (streak.streakDates[i]
                .difference(streak.streakDates[i - 1])
                .inHours <
            24) {
          countStreak++;
        }
        log('Count Streak: $countStreak');
      }
      countStreak++;

      if (countStreak != streak.streakLength) {
        streak.streakLength = countStreak;
      }

      streak.streakLength++;
      streak.streakDates.add(now);
      streak.lastActivity = now;
    }
    await userCollection.doc(uid).update({'streak': streak.toJson()});
  }
}
