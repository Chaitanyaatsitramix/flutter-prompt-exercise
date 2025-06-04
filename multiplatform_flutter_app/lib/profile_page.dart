import 'package:flutter/material.dart';
import 'route_names.dart';

/// Profile page displaying user profile information
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: _buildNavigationDrawer(context),
      body: _buildProfileContent(),
    );
  }

  Widget _buildProfileContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 24),
          _buildProfileSection('Personal Information', [
            _buildInfoTile(Icons.email, 'Email', 'user@example.com'),
            _buildInfoTile(Icons.phone, 'Phone', '+1 (555) 123-4567'),
            _buildInfoTile(Icons.location_on, 'Location', 'San Francisco, CA'),
          ]),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue.shade100,
              child: Icon(Icons.person, size: 48, color: Colors.blue.shade700),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Flutter Developer',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(label),
      subtitle: Text(value),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    final currentRoute =
        ModalRoute.of(context)?.settings.name ?? RouteNames.profile;

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
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: currentRoute == RouteNames.home,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, RouteNames.home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Grid View'),
            selected: currentRoute == RouteNames.grid,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, RouteNames.grid);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            selected: currentRoute == RouteNames.profile,
            onTap: () {
              Navigator.pop(context);
              // Already on profile page
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            selected: currentRoute == RouteNames.settings,
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
