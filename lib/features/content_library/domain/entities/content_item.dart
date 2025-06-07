class ContentItem {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String type; // 'video', 'audio', 'pdf', 'article'
  final String duration;
  final bool isNew;
  final bool isPremium;
  final String? contentUrl; // Added for actual content source

  const ContentItem({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.type,
    required this.duration,
    this.contentUrl, // Added
    this.isNew = false,
    this.isPremium = false,
  });
}
