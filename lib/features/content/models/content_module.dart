class ContentModule {
  final String id;
  final String title;
  final String? description;
  final int order;
  final DateTime createdAt;

  ContentModule({
    required this.id,
    required this.title,
    this.description,
    required this.order,
    required this.createdAt,
  });

  factory ContentModule.fromJson(Map<String, dynamic> json) {
    return ContentModule(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      order: json['order'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'order': order,
      'created_at': createdAt.toIso8601String(),
    };
  }

  ContentModule copyWith({
    String? id,
    String? title,
    String? description,
    int? order,
    DateTime? createdAt,
  }) {
    return ContentModule(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      order: order ?? this.order,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 