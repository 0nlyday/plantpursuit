import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'register.dart'; // Import the RegisterPage
import 'signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plantpursuit/login.dart'; // ปรับเส้นทางการ import ตามโครงสร้างโปรเจคของคุณ

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlantPursuit',
      theme: ThemeData(
        primarySwatch: Colors.green, // Primary color for the app's theme
        scaffoldBackgroundColor: const Color.fromRGBO(
            234, 248, 231, 1.000), // Background color for all screens
      ),
      home: const PlantPursuitPage(), // Set the home screen of the app
    );
  }
}

// Stateful widget for the main PlantPursuit page
class PlantPursuitPage extends StatefulWidget {
  const PlantPursuitPage({Key? key}) : super(key: key);

  @override
  _PlantPursuitPageState createState() => _PlantPursuitPageState();
}

// State class for PlantPursuitPage
class _PlantPursuitPageState extends State<PlantPursuitPage> {
  int _selectedIndex = 0; // Index for the BottomNavigationBar's selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.eco),
        // Leading icon in the AppBar
        title: const Text('PlantPursuit'), // Title in the AppBar
        backgroundColor: const Color.fromRGBO(
            78, 167, 113, 1.000), // Background color of the AppBar
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/background (2).png'), // Set the background image from assets
                fit: BoxFit.cover, // Make the image cover the entire background
              ),
            ),
          ),
          // Main content on top of the background image
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                    Icons.search,
                    'ค้นหา',
                    () =>
                        _openSearchPage(context)), // Button to open search page
                const SizedBox(height: 20), // Spacing between buttons
                _buildButton(Icons.camera_alt, 'กล้อง',
                    () => _openCamera(context)), // Button to open camera
                const SizedBox(height: 20), // Spacing between buttons
                _buildButton(Icons.image, 'แกลลอรี่',
                    () => _openGallery(context)), // Button to open gallery
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'หน้าหลัก'), // Home tab
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'ชื่นชอบ'), // Favorites tab
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'โปรไฟล์'), // Profile tab
        ],
        currentIndex: _selectedIndex, // Set the selected tab index
        selectedItemColor: Color.fromRGBO(
              78, 167, 113, 1.000), // Color of the selected item
        onTap: (index) => _onItemTapped(index, context), // Handle tab selection
      ),
    );
  }

  // Method to build a button with an icon and label
  Widget _buildButton(IconData icon, String label, VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        icon: Icon(icon), // Button icon
        label: Text(label), // Button label
        onPressed: onPressed, // Button press action
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              vertical: 15), // Padding inside the button
          backgroundColor: const Color.fromRGBO(
              78, 167, 113, 1.000), // Button background color
          foregroundColor:
              const Color.fromRGBO(255, 255, 255, 1), // Button text color
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30), // Rounded corners for the button
          ),
        ),
      ),
    );
  }

  // Method to open the search dialog
  void _openSearchPage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ค้นหาพืช'), // Title of the search dialog
          content: TextField(
            decoration: const InputDecoration(
                hintText: 'พิมพ์ชื่อพืชที่ต้องการค้นหา'), // Input field hint
            onSubmitted: (String value) {
              // Handle the search submission
              Navigator.of(context).pop(); // Close the dialog
              _showSnackBar(
                  'กำลังค้นหา: $value'); // Show a snackbar with the search term
            },
          ),
        );
      },
    );
  }

  // Method to open the camera and capture an image
  void _openCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      // If a photo is taken, show a success message
      _showSnackBar('ถ่ายภาพสำเร็จ');
    }
  }

  // Method to open the gallery and pick an image
  void _openGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // If an image is picked, show a success message
      _showSnackBar('เลือกรูปภาพสำเร็จ');
    }
  }

  // Method to handle BottomNavigationBar tab selection
  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index; // Update the selected tab index
    });

    if (index == 2) {
      // If the Profile tab is selected, navigate to the RegisterPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      );
    } else {
      // Show a snackbar with the selected tab name
      _showSnackBar('เลือกแท็บ: ${['หน้าหลัก', 'ชื่นชอบ', 'โปรไฟล์'][index]}');
    }
  }

  // Method to show a snackbar with a message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
