import 'package:flutter/material.dart';
import 'route_names.dart';

/// Settings page displaying app settings and preferences
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: _buildNavigationDrawer(context),
      body: _buildSettingsContent(),
    );
  }

  Widget _buildSettingsContent() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSettingsSection('General', [
          _buildSwitchTile('Push Notifications', true),
          _buildSwitchTile('Email Notifications', false),
          _buildSwitchTile('Dark Mode', false),
        ]),
        const SizedBox(height: 16),
        _buildSettingsSection('Privacy', [
          _buildSwitchTile('Location Services', true),
          _buildSwitchTile('Analytics', false),
          _buildActionTile(Icons.security, 'Privacy Policy'),
        ]),
        const SizedBox(height: 16),
        _buildSettingsSection('Account', [
          _buildActionTile(Icons.person, 'Manage Account'),
          _buildActionTile(Icons.backup, 'Backup & Sync'),
          _buildActionTile(Icons.logout, 'Sign Out', isDestructive: true),
        ]),
      ],
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
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

  Widget _buildSwitchTile(String title, bool value) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: (newValue) {
        // TODO: Handle switch state change
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildActionTile(
    IconData icon,
    String title, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.grey[600]),
      title: Text(
        title,
        style: TextStyle(color: isDestructive ? Colors.red : null),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Handle action
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    final currentRoute =
        ModalRoute.of(context)?.settings.name ?? RouteNames.settings;

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
              Navigator.pushReplacementNamed(context, RouteNames.profile);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            selected: currentRoute == RouteNames.settings,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
