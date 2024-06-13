import 'package:flutter/material.dart';
import 'package:memotask/Firestore/firestore_collections_and_documents.dart';
import 'package:memotask/Models/streakModel.dart';

class Streak_View_Model extends ChangeNotifier {
  Streak _streak = Streak.emptyStreak();

  Streak get streak => _streak;

  void setStreak(Streak streak) {
    _streak = streak;
    notifyListeners();
  }

  void getStreakFromFirestore(String uid) async {
    Streak? strk = await FirestoreRefrence.getSreak(uid);
    if (strk != null) {
      setStreak(strk);
    }
  }

  void updateStreakInFirestore(String uid) async {}
}
