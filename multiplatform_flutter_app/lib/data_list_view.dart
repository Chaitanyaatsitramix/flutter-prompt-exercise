import 'package:flutter/material.dart';
import 'data_item.dart';

/// A custom ListView widget for displaying DataItem objects
///
/// This widget demonstrates several ListView approaches and handles edge cases:
/// - ListView.builder for performance with large datasets
/// - ListView.separated for visual dividers
/// - Robust error handling for null/empty data
/// - Image loading with fallback placeholders
/// - Responsive and accessible design
class DataListView extends StatelessWidget {
  /// List of data items to display
  final List<DataItem>? items;

  /// Whether to show separators between items
  final bool showSeparators;

  /// Custom padding around the ListView
  final EdgeInsets? padding;

  /// Creates a DataListView widget
  const DataListView({
    super.key,
    required this.items,
    this.showSeparators = false,
    this.padding,
  });

  /// Mock data for demonstration purposes
  /// In a real app, this would come from an API, database, or state management
  static List<DataItem> getMockData() {
    return [
      const DataItem(
        title: 'Beautiful Mountain Landscape',
        subtitle: 'A stunning view of snow-capped peaks during golden hour',
        imageUrl: 'https://picsum.photos/seed/mountain/100/100',
      ),
      const DataItem(
        title: 'Modern Architecture',
        subtitle:
            'Contemporary building design with clean lines and glass facades',
        imageUrl: 'https://picsum.photos/seed/building/100/100',
      ),
      const DataItem(
        title: 'Ocean Waves',
        subtitle: 'Peaceful coastal scene with rolling waves and sandy beach',
        imageUrl: 'https://picsum.photos/seed/ocean/100/100',
      ),
      const DataItem(
        title: 'Urban Cityscape',
        subtitle: 'Vibrant city life captured during the evening rush hour',
        imageUrl: 'https://picsum.photos/seed/city/100/100',
      ),
      const DataItem(
        title: 'Forest Trail',
        subtitle: 'Winding path through a lush green forest in early morning',
        imageUrl: 'https://picsum.photos/seed/forest/100/100',
      ),
      const DataItem(
        title: 'Desert Sunset',
        subtitle:
            'Dramatic desert landscape with vibrant orange and purple sky',
        imageUrl: 'https://picsum.photos/seed/desert/100/100',
      ),
      const DataItem(
        title: 'Tech Innovation',
        subtitle: 'Cutting-edge technology and digital transformation concepts',
        imageUrl: null, // Intentionally null to test placeholder handling
      ),
      const DataItem(
        title: 'Garden Paradise',
        subtitle:
            'Botanical garden with exotic flowers and peaceful atmosphere',
        imageUrl: 'https://picsum.photos/seed/garden/100/100',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Edge case: Handle null or empty data
    if (items == null || items!.isEmpty) {
      return _buildEmptyState();
    }

    // Choose ListView implementation based on separator preference
    if (showSeparators) {
      return _buildSeparatedListView();
    } else {
      return _buildStandardListView();
    }
  }

  /// Builds the empty state when no data is available
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No data available',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'There are no items to display at the moment.',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Builds ListView.builder - optimal for performance with large datasets
  ///
  /// ListView.builder vs alternatives:
  /// - ListView.builder: Best for large/dynamic lists, builds items on-demand
  /// - ListView: Best for small, static lists, builds all items at once
  /// - ListView.separated: Like builder but with built-in separators
  /// - ListView.custom: For advanced customization with SliverChildDelegate
  Widget _buildStandardListView() {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: ListView.builder(
        // Item count with null safety
        itemCount: items?.length ?? 0,

        // Builder function called for each visible item
        itemBuilder: (context, index) {
          return _buildListItem(context, items![index], index);
        },

        // Optional: Add physics for better scrolling behavior
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  /// Builds ListView.separated - includes dividers between items
  Widget _buildSeparatedListView() {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: items?.length ?? 0,
        itemBuilder: (context, index) {
          return _buildListItem(context, items![index], index);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            thickness: 0.5,
            indent: 72, // Align with text content
            endIndent: 16,
          );
        },
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  /// Builds individual list item with robust error handling
  Widget _buildListItem(BuildContext context, DataItem item, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        // Leading image with fallback handling
        leading: _buildLeadingImage(item.imageUrl),

        // Title with proper styling
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        // Subtitle with secondary styling
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            item.subtitle,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Add some visual breathing room
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        // Make items interactive
        onTap: () {
          // TODO: Navigate to detail view or perform action
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tapped: ${item.title}'),
              duration: const Duration(seconds: 1),
            ),
          );
        },

        // Accessibility
        mouseCursor: SystemMouseCursors.click,
      ),
    );
  }

  /// Builds the leading image with error handling and placeholders
  Widget _buildLeadingImage(String? imageUrl) {
    // Handle null or empty imageUrl
    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildPlaceholderIcon();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 56,
        height: 56,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          // Loading placeholder
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildLoadingIndicator();
          },
          // Error fallback
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholderIcon();
          },
        ),
      ),
    );
  }

  /// Builds placeholder icon for missing/failed images
  Widget _buildPlaceholderIcon() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.image_outlined, color: Colors.grey[400], size: 32),
    );
  }

  /// Builds loading indicator for images
  Widget _buildLoadingIndicator() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
