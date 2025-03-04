import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fmart/View/auth/userLogin.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class UserprofileScreen extends StatefulWidget {
  const UserprofileScreen({super.key});

  @override
  State<UserprofileScreen> createState() => _UserprofileScreenState();
}

class _UserprofileScreenState extends State<UserprofileScreen> {
  Future<void> logout() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();

      // Pehle check karo ki Google account sign-in hai ya nahi
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut(); // Google Sign-Out
      }

      await FirebaseAuth.instance.signOut(); // Firebase Logout
      Get.offAll(() => LoginScreen()); // Navigate to Login
    } catch (e) {
      print("Logout Error: $e");
    }
  }

  final ImagePicker _imagePicker = ImagePicker();
  File? _file;
  Uint8List? _uint8list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "My Profile",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap:
                        () => showModalBottomSheet(
                          context: context,
                          builder: (context) => _bottomSheet(),
                        ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          _file != null
                              ? FileImage(_file!)
                              : AssetImage(
                                    "assets/images/pexels-photo-415829.webp",
                                  )
                                  as ImageProvider,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amit Kumar",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "amitkumage123@gmail.com",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: Text(
                            "Edit Profile",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _buildListTileWidget(
                icon: Icon(Icons.favorite),
                title: 'Favourites',
                onPressed: () {},
              ),
              _buildListTileWidget(
                icon: Icon(Icons.download),
                title: 'Downloads',
                onPressed: () {},
              ),
              Divider(),
              _buildListTileWidget(
                icon: Icon(Icons.language),
                title: 'Language',
                onPressed: () {},
              ),
              _buildListTileWidget(
                icon: Icon(Icons.location_city),
                title: 'Location',
                onPressed: () {},
              ),
              _buildListTileWidget(
                icon: Icon(Icons.subscript),
                title: 'Feed Preference',
                onPressed: () {},
              ),
              _buildListTileWidget(
                icon: Icon(Icons.favorite),
                title: 'Favourites',
                onPressed: () {},
              ),
              Divider(),
              _buildListTileWidget(
                icon: Icon(Icons.history),
                title: 'Clear history',
                onPressed: () {},
              ),
              _buildListTileWidget(
                icon: Icon(Icons.logout, color: Colors.red),
                title: 'Log Out',
                onPressed: () {
                  logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Choose Profile Photo",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () => _takePhoto(ImageSource.gallery),
                icon: Icon(Icons.photo),
                label: Text("Gallery"),
              ),
              TextButton.icon(
                onPressed: () => _takePhoto(ImageSource.camera),
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _takePhoto(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
  }
}

class _buildListTileWidget extends StatelessWidget {
  const _buildListTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final Icon icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
