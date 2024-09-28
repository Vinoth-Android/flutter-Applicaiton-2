import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:bottombar/database/databasehelper.dart'; // Import your database helper

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    try {
      String? imagePath = await DatabaseHelper().getProfileImage();
      if (imagePath != null) {
        setState(() {
          _image = File(imagePath);
        });
      }
    } catch (e) {
      print('Error loading profile image: $e');
    }
  }

  Future<void> _pickImage() async {
    // Check and request permissions
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final XFile? pickedFile =
            await _picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
          // Save the image path to the database
          await DatabaseHelper().insertProfileImage(pickedFile.path);
        }
      } catch (e) {
        print('Error picking image: $e');
      }
    } else {
      print('Permission denied');
      // Handle permission denial
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              // Handle save action here
            },
            child: const Text('Save',
                style: TextStyle(color: Color.fromARGB(255, 79, 148, 227))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const AssetImage('assets/thamnail.png')
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.photo_camera, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('Name', 'Enter your name'),
              _buildTextField('Email', 'Enter your email'),
              _buildTextField('Mobile No', 'Enter your mobile number'),
              _buildTextField('Date of Birth', 'dd/mm/yyyy'),
              _buildTextField('Address', 'House No, Street Name'),
              _buildTextField('Area/City', 'Area Name, City Name'),
              _buildTextField('State/Pincode', 'State, Pincode'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          ),
        ],
      ),
    );
  }
}
