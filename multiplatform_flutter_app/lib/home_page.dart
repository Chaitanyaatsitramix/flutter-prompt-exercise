import 'package:flutter/material.dart';
import 'data_list_view.dart';
import 'route_names.dart';

/// Home page displaying a ListView of data items
///
/// This is the main content page of the app that demonstrates:
/// - ListView.builder implementation with complex objects
/// - Robust edge-case handling
/// - Navigation drawer integration
/// - Clean, modular StatelessWidget design
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),

      // Navigation drawer for switching between pages
      drawer: _buildNavigationDrawer(context),

      // Main content: ListView of data items
      body: DataListView(
        items: DataListView.getMockData(),
        showSeparators:
            false, // Can be toggled to show ListView.separated variant
      ),

      // Optional: Add floating action button for additional functionality
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Demonstrate switching to separated ListView
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const _HomePageWithSeparators(),
            ),
          );
        },
        tooltip: 'Toggle List Style',
        child: const Icon(Icons.view_list),
      ),
    );
  }

  /// Builds the navigation drawer with route options
  ///
  /// NavigationDrawer vs BottomNavigationBar comparison:
  /// - NavigationDrawer: Better for apps with 3+ main sections, supports more items,
  ///   better for tablets/larger screens, allows for more descriptive labels
  /// - BottomNavigationBar: Better for 2-5 quick-access items, thumb-friendly on mobile,
  ///   always visible for instant navigation
  ///
  /// For this app with 3 main sections, NavigationDrawer is chosen because:
  /// - It scales better if more sections are added later
  /// - Provides better UX on tablets and desktop
  /// - Allows for richer navigation options (dividers, headers, etc.)
  Widget _buildNavigationDrawer(BuildContext context) {
    // Get current route to highlight selected item
    final currentRoute =
        ModalRoute.of(context)?.settings.name ?? RouteNames.home;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header with app branding
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

          // Home navigation item
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: currentRoute == RouteNames.home,
            onTap: () {
              Navigator.pop(context); // Close drawer
              if (currentRoute != RouteNames.home) {
                // Named routing approach
                Navigator.pushReplacementNamed(context, RouteNames.home);

                // Alternative: Anonymous routing approach
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => const HomePage()),
                // );
                //
                // Named vs Anonymous routing comparison:
                // - Named: Better for deep linking, cleaner code organization,
                //   easier route management, supports route guards and middleware
                // - Anonymous: More direct, better type safety, easier parameter passing,
                //   no need for route table setup
                //
                // Named routing is preferred for main navigation flows because:
                // - Consistent with web URL patterns
                // - Easier to manage in larger apps
                // - Better for navigation analytics and deep linking
              }
            },
          ),

          // Grid View navigation item
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Grid View'),
            selected: currentRoute == RouteNames.grid,
            onTap: () {
              Navigator.pop(context);
              if (currentRoute != RouteNames.grid) {
                Navigator.pushReplacementNamed(context, RouteNames.grid);
              }
            },
          ),

          // Profile navigation item
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

          // Settings navigation item
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

          // Divider for visual separation
          const Divider(),

          // Additional options
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

  /// Shows an about dialog with app information
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Flutter Navigation Demo',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.flutter_dash, size: 32),
      children: [
        const Text(
          'A demonstration app showcasing Flutter navigation patterns, '
          'ListView implementations, and UI best practices.',
        ),
      ],
    );
  }
}

/// Alternative home page variant showing ListView.separated
/// This demonstrates how easy it is to switch between ListView styles
class _HomePageWithSeparators extends StatelessWidget {
  const _HomePageWithSeparators();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (with separators)'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: _buildNavigationDrawer(context),
      body: DataListView(
        items: DataListView.getMockData(),
        showSeparators: true, // Using ListView.separated variant
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        tooltip: 'Toggle List Style',
        child: const Icon(Icons.view_agenda),
      ),
    );
  }

  /// Reusable navigation drawer (same as HomePage)
  Widget _buildNavigationDrawer(BuildContext context) {
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
            selected: true,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, RouteNames.home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Grid View'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, RouteNames.grid);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, RouteNames.profile);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, RouteNames.settings);
            },
          ),
        ],
      ),
    );
  }
}
