/// Route constants for named routing
///
/// Using constants for route names provides several benefits:
/// - Type safety and IDE autocompletion
/// - Easy refactoring and maintenance
/// - Centralized route management
/// - Reduced typos and errors
class RouteNames {
  // Private constructor to prevent instantiation
  RouteNames._();

  /// Home page route - displays ListView of data items
  static const String home = '/';

  /// Profile page route - displays user profile information
  static const String profile = '/profile';

  /// Settings page route - displays app settings and preferences
  static const String settings = '/settings';

  /// Grid page route - displays data items in a grid layout
  static const String grid = '/grid';

  /// Detail page route - displays detailed information about a specific item
  static const String detail = '/detail';

  /// List of all available routes for validation
  static const List<String> allRoutes = [home, profile, settings, grid, detail];
}
