/// Data model representing items to be displayed in the ListView
///
/// This class encapsulates the data structure for each item in our list.
/// Using a dedicated model class provides:
/// - Type safety for data handling
/// - Clear structure and documentation
/// - Easy extensibility for future fields
/// - Consistent data representation across the app
class DataItem {
  /// The main title/heading for the item
  final String title;

  /// Additional descriptive text for the item
  final String subtitle;

  /// URL for the image to be displayed (can be null)
  final String? imageUrl;

  /// Creates a new DataItem instance
  ///
  /// [title] and [subtitle] are required, while [imageUrl] is optional
  const DataItem({required this.title, required this.subtitle, this.imageUrl});

  /// Factory constructor to create a DataItem with placeholder data
  /// Useful for testing and fallback scenarios
  factory DataItem.placeholder() {
    return const DataItem(
      title: 'Placeholder Title',
      subtitle: 'Placeholder subtitle text',
      imageUrl: null,
    );
  }

  /// Creates a copy of this DataItem with optionally updated fields
  DataItem copyWith({String? title, String? subtitle, String? imageUrl}) {
    return DataItem(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  /// String representation for debugging
  @override
  String toString() {
    return 'DataItem(title: $title, subtitle: $subtitle, imageUrl: $imageUrl)';
  }

  /// Equality comparison for DataItem objects
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DataItem &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.imageUrl == imageUrl;
  }

  /// Hash code for DataItem objects
  @override
  int get hashCode => Object.hash(title, subtitle, imageUrl);
}
