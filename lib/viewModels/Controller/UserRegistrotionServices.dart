
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fmart/View/auth/userLogin.dart';
import 'package:get/get.dart';

Future<void> UserRegistrationServices(
  String username,
  String userphone,
  DateTime? userdob,
  String? usergender,
  String useremail,
  String userpassword,
) async {
  User? userid = FirebaseAuth.instance.currentUser;
  if (userid == null) {
    Get.snackbar("Error", "User not found. Please try again.",
        snackPosition: SnackPosition.BOTTOM);
    return;
  }

  try {
    await FirebaseFirestore.instance.collection("User").doc(userid.uid).set({
      'UserName': username,
      'UserPhone': userphone,
      'UserDOB': userdob != null ? Timestamp.fromDate(userdob) : null,
      'UserGender': usergender,
      'UserEmail': useremail,
      'UserPassword': userpassword,
      'CreatedAt': Timestamp.now(),
      'UserID': userid.uid,
    });

    await FirebaseAuth.instance.signOut();
    Get.off(() => LoginScreen());
  } on FirebaseAuthException catch (e) {
    Get.snackbar("Signup Failed", e.message ?? "An unknown error occurred",
        snackPosition: SnackPosition.BOTTOM);
  } catch (e) {
    Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
  }
}
