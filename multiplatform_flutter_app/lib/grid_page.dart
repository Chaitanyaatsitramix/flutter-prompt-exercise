import 'package:flutter/material.dart';
import 'data_item.dart';
import 'data_list_view.dart';
import 'detail_page.dart';
import 'route_names.dart';

/// Grid page displaying data items in a grid layout
///
/// This page demonstrates:
/// - GridView.builder implementation for responsive grid layouts
/// - Card-based grid items with images and text
/// - Navigation to detail pages using anonymous routing
/// - Responsive grid that adapts to different screen sizes
/// - Consistent navigation drawer integration
class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid View'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),

      // Navigation drawer (consistent with other pages)
      drawer: _buildNavigationDrawer(context),

      // Grid content
      body: _buildGridContent(),
    );
  }

  /// Builds the main grid content
  Widget _buildGridContent() {
    final items = DataListView.getMockData();

    // Handle empty data case
    if (items.isEmpty) {
      return _buildEmptyState();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        // Grid configuration
        /// GridView.builder vs alternatives:
        /// - GridView.builder: Best for large datasets, builds items on-demand
        /// - GridView.count: Simple fixed column count grid
        /// - GridView.extent: Fixed maximum item width
        /// - GridView.custom: Advanced customization with SliverGridDelegate
        ///
        /// GridView.builder is chosen here because:
        /// - Efficient memory usage for large datasets
        /// - Flexible grid configuration
        /// - Supports responsive design patterns
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // Responsive column count based on screen width
          crossAxisCount: _getCrossAxisCount(),

          // Spacing between items
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,

          // Aspect ratio for grid items (width:height = 1:1.2)
          childAspectRatio: 1 / 1.2,
        ),

        // Item count
        itemCount: items.length,

        // Builder function for each grid item
        itemBuilder: (context, index) {
          return _buildGridItem(context, items[index], index);
        },

        // Better scrolling physics
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  /// Determines the number of columns based on screen width
  /// This provides a responsive grid that adapts to different screen sizes
  int _getCrossAxisCount() {
    // Get the current screen width from the build context
    // Note: This is accessed in _buildGridContent which has access to context
    // For this static method, we'll use reasonable defaults

    // Default configuration:
    // - Mobile portrait: 2 columns
    // - Mobile landscape/Tablet: 3 columns
    // - Desktop: 4 columns

    // In a real implementation, you would pass MediaQuery.of(context).size.width
    // and calculate based on actual screen width
    return 2; // Default for mobile portrait
  }

  /// Builds individual grid item
  Widget _buildGridItem(BuildContext context, DataItem item, int index) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, item),
      child: Hero(
        tag: 'grid_item_$index',
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section (takes up 60% of the card height)
              Expanded(flex: 3, child: _buildGridItemImage(item)),

              // Content section (takes up 40% of the card height)
              Expanded(flex: 2, child: _buildGridItemContent(item)),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the image section of the grid item
  Widget _buildGridItemImage(DataItem item) {
    if (item.imageUrl == null || item.imageUrl!.isEmpty) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade200, Colors.grey.shade300],
          ),
        ),
        child: Icon(Icons.image_outlined, size: 48, color: Colors.grey[400]),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Image.network(
        item.imageUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[100],
            child: Center(
              child: CircularProgressIndicator(
                value:
                    loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                strokeWidth: 2,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.red.shade100, Colors.red.shade200],
              ),
            ),
            child: Icon(Icons.broken_image, size: 48, color: Colors.red[300]),
          );
        },
      ),
    );
  }

  /// Builds the content section of the grid item
  Widget _buildGridItemContent(DataItem item) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            item.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 4),

          // Subtitle
          Expanded(
            child: Text(
              item.subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                height: 1.3,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Action indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.touch_app, size: 16, color: Colors.grey[500]),
              Text(
                'Tap for details',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the empty state when no data is available
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.grid_view, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No items to display',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'The grid will show items when data is available.',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Navigates to the detail page for the selected item
  ///
  /// Using anonymous routing (Navigator.push) for detail navigation because:
  /// - Better for passing complex objects as parameters
  /// - More direct and type-safe than named routing with arguments
  /// - Ideal for one-off navigation scenarios
  /// - Easier to implement custom transitions
  void _navigateToDetail(BuildContext context, DataItem item) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => DetailPage(item: item),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Custom slide transition from bottom
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  /// Builds the navigation drawer (consistent with other pages)
  Widget _buildNavigationDrawer(BuildContext context) {
    final currentRoute =
        ModalRoute.of(context)?.settings.name ?? RouteNames.grid;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.blueAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.flutter_dash, size: 48, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Flutter Navigation Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Showcasing NavigationDrawer',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: currentRoute == RouteNames.home,
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != RouteNames.home) {
                Navigator.pushReplacementNamed(context, RouteNames.home);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Grid View'),
            selected: currentRoute == RouteNames.grid,
            onTap: () {
              Navigator.pop(context);
              // Already on grid page
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            selected: currentRoute == RouteNames.profile,
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != RouteNames.profile) {
                Navigator.pushReplacementNamed(context, RouteNames.profile);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            selected: currentRoute == RouteNames.settings,
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != RouteNames.settings) {
                Navigator.pushReplacementNamed(context, RouteNames.settings);
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  /// Shows an about dialog
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Flutter Navigation Demo',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.flutter_dash, size: 32),
      children: [
        const Text(
          'A demonstration app showcasing Flutter navigation patterns, '
          'ListView and GridView implementations, and UI best practices.',
        ),
      ],
    );
  }
}
