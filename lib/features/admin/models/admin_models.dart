class AdminStats {
  final int totalUsers;
  final int totalSubscribers;
  final int recentContents;
  final int pendingModeration;

  AdminStats({
    required this.totalUsers,
    required this.totalSubscribers,
    required this.recentContents,
    required this.pendingModeration,
  });
}

class AdminUser {
  final String id;
  final String email;
  final String name;
  final String role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime lastLogin;

  AdminUser({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.lastLogin,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      lastLogin: DateTime.parse(json['last_login']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'last_login': lastLogin.toIso8601String(),
    };
  }
}

class AdminContent {
  final String id;
  final String title;
  final String type; // 'module', 'folder', 'lesson'
  final String? parentId;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? authorId;
  final String? authorName;

  AdminContent({
    required this.id,
    required this.title,
    required this.type,
    this.parentId,
    required this.isPublished,
    required this.createdAt,
    this.updatedAt,
    this.authorId,
    this.authorName,
  });
}

class AdminComment {
  final String id;
  final String content;
  final String authorId;
  final String authorName;
  final String contentType; // 'lesson', 'forum'
  final String contentId;
  final String contentTitle;
  final bool isReported;
  final bool isApproved;
  final DateTime createdAt;

  AdminComment({
    required this.id,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.contentType,
    required this.contentId,
    required this.contentTitle,
    required this.isReported,
    required this.isApproved,
    required this.createdAt,
  });
}

class AdminLesson {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final int durationMinutes;
  final bool isPremium;
  final String? moduleId;
  final String? folderId;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdminLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.durationMinutes,
    required this.isPremium,
    this.moduleId,
    this.folderId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdminLesson.fromJson(Map<String, dynamic> json) {
    return AdminLesson(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnail_url'],
      durationMinutes: json['duration_minutes'],
      isPremium: json['is_premium'],
      moduleId: json['module_id'],
      folderId: json['folder_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail_url': thumbnailUrl,
      'duration_minutes': durationMinutes,
      'is_premium': isPremium,
      'module_id': moduleId,
      'folder_id': folderId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class AdminModule {
  final String id;
  final String title;
  final String description;
  final String coverUrl;
  final bool isPremium;
  final int totalLessons;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdminModule({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.isPremium,
    required this.totalLessons,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdminModule.fromJson(Map<String, dynamic> json) {
    return AdminModule(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      coverUrl: json['cover_url'],
      isPremium: json['is_premium'],
      totalLessons: json['total_lessons'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'cover_url': coverUrl,
      'is_premium': isPremium,
      'total_lessons': totalLessons,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class AdminChallenge {
  final String id;
  final String title;
  final String description;
  final int points;
  final DateTime startDate;
  final DateTime endDate;
  final int totalParticipants;
  final int completedParticipants;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  AdminChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.startDate,
    required this.endDate,
    required this.totalParticipants,
    required this.completedParticipants,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory AdminChallenge.fromJson(Map<String, dynamic> json) {
    return AdminChallenge(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      points: json['points'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      totalParticipants: json['total_participants'],
      completedParticipants: json['completed_participants'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'points': points,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'total_participants': totalParticipants,
      'completed_participants': completedParticipants,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
    };
  }
}

class AdminBadge {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final String criteria;
  final int totalAwarded;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  AdminBadge({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.criteria,
    required this.totalAwarded,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory AdminBadge.fromJson(Map<String, dynamic> json) {
    return AdminBadge(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconUrl: json['icon_url'],
      criteria: json['criteria'],
      totalAwarded: json['total_awarded'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon_url': iconUrl,
      'criteria': criteria,
      'total_awarded': totalAwarded,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
    };
  }
}

class AdminSettings {
  final bool isDarkMode;
  final String language;
  final bool notificationsEnabled;
  final bool autoSaveEnabled;
  final int autoSaveInterval;

  AdminSettings({
    required this.isDarkMode,
    required this.language,
    required this.notificationsEnabled,
    required this.autoSaveEnabled,
    required this.autoSaveInterval,
  });

  factory AdminSettings.fromJson(Map<String, dynamic> json) {
    return AdminSettings(
      isDarkMode: json['is_dark_mode'],
      language: json['language'],
      notificationsEnabled: json['notifications_enabled'],
      autoSaveEnabled: json['auto_save_enabled'],
      autoSaveInterval: json['auto_save_interval'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_dark_mode': isDarkMode,
      'language': language,
      'notifications_enabled': notificationsEnabled,
      'auto_save_enabled': autoSaveEnabled,
      'auto_save_interval': autoSaveInterval,
    };
  }
}

class AdminAnalytics {
  final int totalUsers;
  final int activeUsers;
  final int totalLessons;
  final int totalModules;
  final int totalChallenges;
  final int totalBadges;
  final List<Map<String, dynamic>> userActivity;
  final List<Map<String, dynamic>> popularContent;
  final List<Map<String, dynamic>> revenueData;

  AdminAnalytics({
    required this.totalUsers,
    required this.activeUsers,
    required this.totalLessons,
    required this.totalModules,
    required this.totalChallenges,
    required this.totalBadges,
    required this.userActivity,
    required this.popularContent,
    required this.revenueData,
  });

  factory AdminAnalytics.fromJson(Map<String, dynamic> json) {
    return AdminAnalytics(
      totalUsers: json['total_users'],
      activeUsers: json['active_users'],
      totalLessons: json['total_lessons'],
      totalModules: json['total_modules'],
      totalChallenges: json['total_challenges'],
      totalBadges: json['total_badges'],
      userActivity: List<Map<String, dynamic>>.from(json['user_activity']),
      popularContent: List<Map<String, dynamic>>.from(json['popular_content']),
      revenueData: List<Map<String, dynamic>>.from(json['revenue_data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_users': totalUsers,
      'active_users': activeUsers,
      'total_lessons': totalLessons,
      'total_modules': totalModules,
      'total_challenges': totalChallenges,
      'total_badges': totalBadges,
      'user_activity': userActivity,
      'popular_content': popularContent,
      'revenue_data': revenueData,
    };
  }
}
