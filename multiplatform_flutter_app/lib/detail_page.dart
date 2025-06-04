import 'package:flutter/material.dart';
import 'data_item.dart';

/// Detail page displaying comprehensive information about a specific DataItem
///
/// This page demonstrates:
/// - Anonymous routing for detail views (Navigator.push with parameters)
/// - Rich content layout with images and text
/// - Responsive design across different screen sizes
/// - Hero animations for smooth transitions
class DetailPage extends StatelessWidget {
  /// The data item to display details for
  final DataItem item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero image in app bar
          _buildSliverAppBar(context),

          // Content sections
          SliverToBoxAdapter(child: _buildContent(context)),
        ],
      ),
    );
  }

  /// Builds the sliver app bar with hero image
  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          item.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 3,
                color: Colors.black54,
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        background: _buildHeroImage(),
      ),
    );
  }

  /// Builds the hero image with fallback handling
  Widget _buildHeroImage() {
    if (item.imageUrl == null || item.imageUrl!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.blue.shade700],
          ),
        ),
        child: const Center(
          child: Icon(Icons.image_outlined, size: 120, color: Colors.white54),
        ),
      );
    }

    return Hero(
      tag: 'image_${item.title}',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(item.imageUrl!),
            fit: BoxFit.cover,
            onError: (error, stackTrace) {
              // Handle image loading error
            },
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the main content sections
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description section
          _buildSection(
            'Description',
            Text(
              item.subtitle,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),

          const SizedBox(height: 24),

          // Additional details section
          _buildSection(
            'Details',
            Column(
              children: [
                _buildDetailRow('Title', item.title),
                const SizedBox(height: 12),
                _buildDetailRow('Type', _getItemType()),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Image Available',
                  item.imageUrl != null ? 'Yes' : 'No',
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Character Count',
                  '${item.subtitle.length} characters',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Related actions section
          _buildSection(
            'Actions',
            Column(
              children: [
                _buildActionButton(
                  context,
                  Icons.share,
                  'Share',
                  () => _shareItem(context),
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  context,
                  Icons.favorite_border,
                  'Add to Favorites',
                  () => _addToFavorites(context),
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  context,
                  Icons.edit,
                  'Edit',
                  () => _editItem(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Metadata section
          _buildSection(
            'Metadata',
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildMetadataRow('Created', 'Today'),
                    const Divider(),
                    _buildMetadataRow('Last Modified', '2 hours ago'),
                    const Divider(),
                    _buildMetadataRow('Views', '127'),
                    const Divider(),
                    _buildMetadataRow('Rating', '4.5 ⭐'),
                  ],
                ),
              ),
            ),
          ),

          // Bottom spacing
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// Builds a section with title and content
  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  /// Builds a detail row with label and value
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
      ],
    );
  }

  /// Builds an action button
  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  /// Builds a metadata row
  Widget _buildMetadataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  /// Determines the item type based on keywords in the title
  String _getItemType() {
    final title = item.title.toLowerCase();
    if (title.contains('mountain') || title.contains('landscape')) {
      return 'Nature';
    } else if (title.contains('architecture') || title.contains('building')) {
      return 'Architecture';
    } else if (title.contains('ocean') || title.contains('waves')) {
      return 'Seascape';
    } else if (title.contains('city') || title.contains('urban')) {
      return 'Urban';
    } else if (title.contains('tech') || title.contains('innovation')) {
      return 'Technology';
    } else {
      return 'General';
    }
  }

  /// Shares the item (placeholder implementation)
  void _shareItem(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: ${item.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Adds item to favorites (placeholder implementation)
  void _addToFavorites(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added "${item.title}" to favorites'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Placeholder undo action
          },
        ),
      ),
    );
  }

  /// Edits the item (placeholder implementation)
  void _editItem(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Item'),
            content: Text(
              'Edit functionality for "${item.title}" would be implemented here.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }
}
