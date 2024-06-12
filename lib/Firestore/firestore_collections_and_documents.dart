import 'dart:developer';

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

  static Future<void> updateStreak(String uid) async {
    Streak? streak = await getSreak(uid);
    if (streak == null) {
      return;
    }
    List<DateTime> streakDates = streak.streakDates;
    DateTime lastActivity = streak.lastActivity;
    DateTime today = DateTime.now();
    if (lastActivity.day == today.day) {
      return;
    }
    if (lastActivity.day + 1 == today.day) {
      streakDates.add(today);
    } else {
      streakDates.clear();
      streakDates.add(today);
    }
    Streak newStreak = Streak(
      startDate: streak.startDate,
      endDate: streak.endDate,
      streakLength: streak.streakLength,
      longestStreak: streak.longestStreak,
      lastActivity: today,
      streakDates: streakDates,
    );
    await userCollection.doc(uid).update({'streak': newStreak.toJson()});
  }
}
