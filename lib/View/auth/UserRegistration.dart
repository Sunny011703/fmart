import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fmart/View/auth/userLogin.dart';
import 'package:fmart/viewModels/Controller/UserRegistrotionServices.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String? selectedGender;
  DateTime? selectedDate;
  bool isPasswordVisible = false;

  //-------------> Method to toggle Password Visibilty <-------------------

  void togglePasswordVisiblity() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  //-------------> User Name Method <---------------

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  //---------> User Email <-----------------//
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  //----------->  User Number <-------------//
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  //----------> User Password <-------------//
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateDOB(DateTime? value) {
    if (value == null) {
      return 'Please select your date of birth';
    }
    return null;
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 55.0, horizontal: 16.0),
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                Text(
                  "Registration",
                  style: GoogleFonts.poppins(
                    fontSize: screenHeight * 0.03,
                    color: Colors.blueAccent,
                  ),
                ),
                Container(
                  width: screenWidth * 0.9,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Welcome to Registration Page",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      // Name Field
                      Text(
                        "Name",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Enter your Name",
                        ),
                        validator: validateName,
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // Email Field
                      Text(
                        "Phone Number",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.phone),
                          hintText: "Enter your Phone Number",
                        ),
                        validator: validatePhone,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // DOB & Gender Row
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("DOB"),
                                GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            selectedDate == null
                                                ? "Select DOB"
                                                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                      ),
                                      validator:
                                          (value) => validateDOB(selectedDate),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Gender"),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  value: selectedGender,
                                  hint: const Text("Select Gender"),
                                  items:
                                      ["Male", "Female", "Other"].map((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedGender = newValue;
                                    });
                                  },
                                  validator: validateGender,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Email Field
                      Text(
                        "Email ID",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.email),

                          hintText: "Enter your Email ID",
                        ),
                        validator: validateEmail,
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Email Field
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.numbers),

                          suffixIcon: IconButton(
                            onPressed: togglePasswordVisiblity,
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          hintText: "Enter your Password",
                        ),
                        validator: validatePassword,
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_globalKey.currentState!.validate()) {
                              var username = nameController.text.trim();
                              var userphone = phoneController.text.trim();
                              var userdob = selectedDate;
                              var usergender = selectedGender;
                              var useremail = emailController.text.trim();
                              var userpassword = passwordController.text.trim();
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                      email: useremail,
                                      password: userpassword,
                                    );
                                UserRegistrationServices(
                                  username,
                                  userphone,
                                  userdob,
                                  usergender,
                                  useremail,
                                  userpassword,
                                );
                                Get.to(()=>LoginScreen());
                                nameController.clear();
                                phoneController.clear();
                                emailController.clear();
                                passwordController.clear();
                                Get.snackbar(
                                  "Success",
                                  "Account created successfully!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.green
                                );
                              } catch (e) {
                                Get.snackbar(
                                  "Error",
                                  e.toString(),
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.3,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Register",
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
