import 'dart:developer';

class Streak {
  final DateTime startDate;
  final DateTime endDate;
  final DateTime lastActivity;
  final int streakLength;
  final int longestStreak;
  final List<DateTime> streakDates;

  Streak({
    required this.startDate,
    required this.endDate,
    required this.streakLength,
    required this.longestStreak,
    required this.lastActivity,
    required this.streakDates,
  });

  Streak.fromJson(Map<String, dynamic> json)
      : startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']),
        streakLength = json['streakLength'],
        longestStreak = json['longestStreak'],
        lastActivity = DateTime.parse(json['lastActivity']),
        streakDates = List<DateTime>.from(json['streakDates']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate.toIso8601String();
    data['endDate'] = endDate.toIso8601String();
    data['streakLength'] = streakLength;
    data['longestStreak'] = longestStreak;
    data['lastActivity'] = lastActivity.toIso8601String();
    data['streakDates'] = streakDates.map((e) => e.toIso8601String()).toList();

    return data;
  }

  @override
  String toString() {
    return 'Streak{startDate: $startDate, endDate: $endDate, streakLength: $streakLength, longestStreak: $longestStreak lastActivity: $lastActivity streakDates: $streakDates}';
  }

  void logStreak() {
    log(toString());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Streak &&
          runtimeType == other.runtimeType &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          streakLength == other.streakLength &&
          longestStreak == other.longestStreak &&
          lastActivity == other.lastActivity &&
          streakDates == other.streakDates;

  Streak resetStreak() {
    return Streak(
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      streakLength: 0,
      longestStreak: 0,
      lastActivity: DateTime.now(),
      streakDates: [],
    );
  }

  Streak incrementStreak() {
    final newEndDate = DateTime.now();
    final newStreakLength = streakLength + 1;
    final newLongestStreak =
        newStreakLength > longestStreak ? newStreakLength : longestStreak;
    final newLastActivity = DateTime.now();
    return Streak(
      startDate: startDate,
      endDate: newEndDate,
      streakLength: newStreakLength,
      longestStreak: newLongestStreak,
      lastActivity: newLastActivity,
      streakDates: [...streakDates, newLastActivity],
    );
  }
}
