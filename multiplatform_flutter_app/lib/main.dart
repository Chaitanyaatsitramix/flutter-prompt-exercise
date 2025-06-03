import 'package:flutter/material.dart';

/// Entry point of the Flutter application
/// This is where the app starts execution
void main() {
  // runApp() takes the root widget and makes it the root of the widget tree
  runApp(const MyApp());
}

/// Root widget of the application
/// StatelessWidget is used because this widget doesn't need to maintain any state
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Build method defines the widget's UI
  /// BuildContext provides information about the widget's location in the widget tree
  @override
  Widget build(BuildContext context) {
    // MaterialApp provides Material Design theming and navigation structure
    // It's the top-level widget for Material Design apps
    return MaterialApp(
      // Title appears in the task manager on desktop platforms
      title: 'TextField Demo',

      // Theme defines the visual properties of the app
      theme: ThemeData(
        // Creates a color scheme based on a seed color
        // Material 3 design system automatically generates harmonious colors
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        // Use Material 3 design system for modern UI components
        useMaterial3: true,
      ),

      // home defines the default route of the app
      // This is the first screen users see when the app launches
      home: const TextFieldDemoPage(),
    );
  }
}

/// Main page widget that contains our TextField
/// StatefulWidget is used because we need to manage the TextEditingController
class TextFieldDemoPage extends StatefulWidget {
  const TextFieldDemoPage({super.key});

  @override
  State<TextFieldDemoPage> createState() => _TextFieldDemoPageState();
}

/// State class for TextFieldDemoPage
/// This class manages the lifecycle and state of our TextField
class _TextFieldDemoPageState extends State<TextFieldDemoPage> {
  // TextEditingController is used to control and retrieve text from TextField
  // It provides methods to get text, set text, and listen to changes
  late TextEditingController _nameController;

  /// initState is called once when the widget is first created
  /// This is where we initialize our TextEditingController
  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingController
    // This controller will be attached to our TextField to manage its text
    _nameController = TextEditingController();
  }

  /// dispose is called when the widget is removed from the widget tree
  /// This is where we clean up resources to prevent memory leaks
  @override
  void dispose() {
    // Always dispose of TextEditingController to free up memory
    // Failing to do this can cause memory leaks in your app
    _nameController.dispose();
    super.dispose();
  }

  /// Method to demonstrate retrieving text from the TextField
  /// This shows how to access the current text value
  void _showEnteredText() {
    // Get the current text from the controller
    // The .text property contains the current string in the TextField
    String enteredText = _nameController.text;

    // Print to console to demonstrate text retrieval
    // In a real app, you might save this to a database or send to a server
    print('Entered text: $enteredText');

    // Show a snackbar to provide visual feedback to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You entered: $enteredText'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure for a screen
    // It includes app bar, body, floating action buttons, drawers, etc.
    return Scaffold(
      // AppBar creates the top bar of the screen
      appBar: AppBar(
        // The title that appears in the app bar
        title: const Text('TextField Demo'),
        // Use the primary color from our theme
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      // Body contains the main content of the screen
      body: Padding(
        // Padding adds space around the child widget
        // EdgeInsets.all(16.0) adds 16 pixels of space on all sides
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // Center widget centers its child both horizontally and vertically
          child: Column(
            // Column arranges children vertically
            // MainAxisAlignment.center centers children along the vertical axis
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextField is the main input widget for text entry
              // It allows users to enter and edit text
              TextField(
                // Attach the TextEditingController to this TextField
                // This allows us to programmatically control and retrieve the text
                controller: _nameController,

                // InputDecoration defines the visual appearance of the TextField
                // It controls borders, labels, hints, icons, and other visual elements
                decoration: const InputDecoration(
                  // labelText creates a floating label that moves up when focused
                  // This provides a clear indication of what input is expected
                  labelText: 'Enter your name',

                  // hintText provides additional guidance when the field is empty
                  hintText: 'Type your full name here',

                  // border defines the outline around the TextField
                  // OutlineInputBorder creates a rectangular border around the field
                  border: OutlineInputBorder(),

                  // prefixIcon adds an icon at the beginning of the field
                  // This provides visual context for the type of input expected
                  prefixIcon: Icon(Icons.person),
                ),

                // textInputAction determines what action button appears on the keyboard
                // TextInputAction.done shows a "Done" button that closes the keyboard
                textInputAction: TextInputAction.done,

                // onSubmitted is called when the user submits the text
                // This typically happens when they press the action button on the keyboard
                onSubmitted: (value) {
                  // Call our method to show the entered text
                  _showEnteredText();
                },
              ),

              // SizedBox creates empty space between widgets
              // Here it adds 20 pixels of vertical space
              const SizedBox(height: 20),

              // ElevatedButton provides a way to trigger an action
              // This demonstrates how to retrieve text programmatically
              ElevatedButton(
                // onPressed callback is executed when the button is tapped
                onPressed: _showEnteredText,

                // Style the button for better appearance
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),

                // child defines what's displayed inside the button
                child: const Text('Show Entered Text'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
