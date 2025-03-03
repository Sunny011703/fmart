import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fmart/AnimatedBottonNavigationBar.dart';
import 'package:fmart/View/auth/userLogin.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulating delay
    setState(() {
      user = FirebaseAuth.instance.currentUser;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:
          isLoading
              ? const Scaffold(
                backgroundColor: Colors.blueAccent,
                body: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              )
              : (user != null
                  ? AnimatedBottomNavigationBar()
                  : const LoginScreen()),
    );
  }
}
