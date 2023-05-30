class DummyStatsData {
  static final List<HabitTracker> habitTrackers = [
    HabitTracker(name: 'Call Parents', streak: 12),
    HabitTracker(name: 'Revision', streak: 8),
    HabitTracker(name: 'Drink Water', streak: 21),
    HabitTracker(name: 'Go for a Walk', streak: 16),
    HabitTracker(name: 'Daily Journal', streak: 30),
    HabitTracker(name: 'Sleep Early', streak: 25),
  ];

  static final List<int> habitsCompletedWeek = [4, 2, 2, 3, 0, 1, 0];
  static final List<int> habitsCompletedMonth = [1, 4, 5, 3, 5, 3, 3, 2, 6, 5, 4, 5, 2, 4, 4, 2, 2, 3, 0, 1, 0, 4, 1, 2, 6, 4, 5, 4, 0, 5, 0];

  static final List<int> tasksCompletedWeek = [1, 3, 1, 14, 13, 3, 6];
  static final List<int> tasksCompletedMonth = [8, 3, 15, 10, 15, 9, 14, 1, 3, 1, 14, 13, 3, 6, 10, 14, 5, 15, 9, 14, 13, 2, 3, 7, 3, 12, 6, 9, 9, 5, 0];

  static const int totalTasksCompleted = 150;
  static const int currentHabitsTracked = 3;
  static const int highestHabitStreak = 21;
}

class HabitTracker {
  final String name;
  final int streak;

  HabitTracker({required this.name, required this.streak});
}
