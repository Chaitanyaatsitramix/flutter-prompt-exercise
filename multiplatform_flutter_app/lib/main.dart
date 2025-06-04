import 'package:flutter/material.dart';
import 'route_names.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'grid_page.dart';

/// Main entry point for the Flutter Navigation Demo app
///
/// This app demonstrates:
/// - Named routing vs Anonymous routing approaches
/// - NavigationDrawer implementation across multiple screens
/// - ListView.builder with robust edge-case handling
/// - Clean, modular StatelessWidget architecture
/// - Responsive and attractive UI design
void main() {
  runApp(const MyApp());
}

/// Main application widget
///
/// StatefulWidget vs StatelessWidget decision:
/// - MyApp is StatelessWidget because it doesn't need to manage any internal state
/// - Individual pages are StatelessWidget for simplicity and performance
/// - If we needed to manage global app state (theme, user preferences),
///   we could use a StatefulWidget here or implement state management (Provider, Bloc, etc.)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App metadata
      title: 'Flutter Navigation Demo',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,

        // Improve drawer animation and visual consistency
        drawerTheme: const DrawerThemeData(elevation: 16),

        // Card theme for consistent elevated surfaces
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // List tile theme for consistent spacing
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        ),
      ),

      // Named routing configuration
      // This is the preferred approach for main navigation flows because:
      // - Better URL support for web
      // - Easier deep linking implementation
      // - Cleaner separation of navigation logic
      // - Better analytics and debugging
      // - Consistent with web development patterns
      initialRoute: RouteNames.home,
      routes: _buildRoutes(),

      // Route generation for handling unknown routes
      onGenerateRoute: _onGenerateRoute,

      // Error route for navigation failures
      onUnknownRoute: _onUnknownRoute,
    );
  }

  /// Builds the route table for named routing
  ///
  /// Named routing vs Anonymous routing comparison:
  ///
  /// Named Routing (used here):
  /// - Pros: Clean URLs, deep linking, centralized route management,
  ///         better for large apps, easier testing and debugging
  /// - Cons: Extra setup, less type safety for parameters
  /// - Best for: Main navigation flows, web apps, deep linking scenarios
  ///
  /// Anonymous Routing (Navigator.push):
  /// - Pros: Direct and simple, better type safety, easier parameter passing,
  ///         more flexible for dynamic navigation
  /// - Cons: No URL support, harder to manage in large apps, no deep linking
  /// - Best for: Modal screens, dialogs, temporary navigation, parameter-heavy routes
  ///
  /// Hybrid Approach:
  /// In practice, many apps use both:
  /// - Named routes for main navigation (Home, Profile, Settings)
  /// - Anonymous routes for detail screens, modals, and forms
  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      RouteNames.home: (context) => const HomePage(),
      RouteNames.grid: (context) => const GridPage(),
      RouteNames.profile: (context) => const ProfilePage(),
      RouteNames.settings: (context) => const SettingsPage(),
    };
  }

  /// Handles route generation for parameterized routes
  /// This could be used for routes that need parameters, like:
  /// '/user/123' or '/product/abc'
  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    // Example of how to handle parameterized routes:
    // if (settings.name?.startsWith('/user/') == true) {
    //   final userId = settings.name!.split('/').last;
    //   return MaterialPageRoute(
    //     builder: (context) => UserDetailPage(userId: userId),
    //     settings: settings,
    //   );
    // }

    return null; // Let the app handle with onUnknownRoute
  }

  /// Fallback route for unknown navigation attempts
  Route<dynamic> _onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder:
          (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Page Not Found'),
              backgroundColor: Colors.red.shade400,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Page Not Found',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The route "${settings.name}" could not be found.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, RouteNames.home);
                    },
                    child: const Text('Go to Home'),
                  ),
                ],
              ),
            ),
          ),
      settings: settings,
    );
  }
}

/// Alternative main app implementation using StatefulWidget
/// 
/// This approach would be useful if you need to:
/// - Manage global app state (theme, user authentication, etc.)
/// - Handle app lifecycle events
/// - Implement state management patterns
/// 
/// Example usage:
/// ```dart
/// class MyStatefulApp extends StatefulWidget {
///   const MyStatefulApp({super.key});
/// 
///   @override
///   State<MyStatefulApp> createState() => _MyStatefulAppState();
/// }
/// 
/// class _MyStatefulAppState extends State<MyStatefulApp> {
///   ThemeMode _themeMode = ThemeMode.system;
///   String _selectedRoute = RouteNames.home;
/// 
///   void _updateTheme(ThemeMode mode) {
///     setState(() {
///       _themeMode = mode;
///     });
///   }
/// 
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       themeMode: _themeMode,
///       // ... rest of the configuration
///     );
///   }
/// }
/// ```
/// 
/// For this demo app, StatelessWidget is sufficient since we don't need 
/// to manage global state. However, real-world apps often benefit from
/// StatefulWidget for the main app class or state management solutions
/// like Provider, Bloc, or Riverpod.
