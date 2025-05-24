class UserProgress {
  final String level;
  final int currentPoints;
  final int nextLevelPoints;
  final double progressPercentage;

  const UserProgress({
    required this.level,
    required this.currentPoints,
    required this.nextLevelPoints,
    required this.progressPercentage,
  });
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final int durationMinutes;
  final bool isPremium;
  final double progress;
  final String? moduleId;
  final String? folderId;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.durationMinutes,
    required this.isPremium,
    required this.progress,
    this.moduleId,
    this.folderId,
  });
}

class Module {
  final String id;
  final String title;
  final String description;
  final String coverUrl;
  final bool isPremium;
  final double progress;
  final int totalLessons;
  final int completedLessons;

  const Module({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.isPremium,
    required this.progress,
    required this.totalLessons,
    required this.completedLessons,
  });
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final int points;
  final DateTime startDate;
  final DateTime endDate;
  final double progress;
  final int totalParticipants;
  final int completedParticipants;

  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.startDate,
    required this.endDate,
    required this.progress,
    required this.totalParticipants,
    required this.completedParticipants,
  });
}

class DailyTip {
  final String message;
  final String author;

  const DailyTip({
    required this.message,
    required this.author,
  });
}

class DashboardData {
  final List<Lesson> continueLearning;
  final List<Lesson> recommendedLessons;
  final List<Module> modules;
  final List<Challenge> challenges;
  final DailyTip dailyTip;
  final UserProgress userProgress;

  const DashboardData({
    required this.continueLearning,
    required this.recommendedLessons,
    required this.modules,
    required this.challenges,
    required this.dailyTip,
    required this.userProgress,
  });
}
