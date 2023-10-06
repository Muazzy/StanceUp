import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/utils/show_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository extends ChangeNotifier {
  final FirebaseAuth _auth;
  AuthRepository(this._auth);

  bool isLoading = false;

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  static String get currentUserUid =>
      FirebaseAuth.instance.currentUser?.uid ?? '';

  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  // Stream<bool> get authState =>
  //     _auth.authStateChanges().map((user) => user != null);
  Stream<User?> get authState => _auth.authStateChanges();

  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();

  // // EMAIL SIGN UP
  // Future<void> signUpWithEmail({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //     FocusScope.of(context).unfocus();

  //     final newUser = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     await newUser.user?.updateDisplayName(name).whenComplete(
  //       () {
  //         isLoading = false;
  //         notifyListeners();
  //         if (currentUserUid.isNotEmpty) {
  //           Navigator.pushNamedAndRemoveUntil(
  //             context,
  //             '/rootScreen',
  //             (route) => false,
  //           );
  //         }
  //       },
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     // if you want to display your own custom error message
  //     if (e.code == 'weak-password') {
  //       debugPrint('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       debugPrint('The account already exists for that email.');
  //     }
  //     showSnackBar(
  //         context, e.message!); // Displaying the firebase error message
  //   }
  // }

  Future<Map<String, dynamic>> getUserInfo(String userId) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('users');
      final userDoc = await userRef.doc(userId).get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        return userData;
      } else {
        // User document does not exist in Firestore
        return {};
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error getting user information: $e');
      return {};
    }
  }

// EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      FocusScope.of(context).unfocus();

      final newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await newUser.user?.updateDisplayName(name).whenComplete(
        () async {
          isLoading = false;
          notifyListeners();
          if (currentUserUid.isNotEmpty) {
            // Call saveUser to save the user's information to Firestore
            await saveUser(
              name, // Name from the function parameter
              email, // Email from the function parameter
            );
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/rootScreen',
                (route) => false,
              );
            }
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
      showSnackBar(
        context,
        e.message!,
      ); // Displaying the firebase error message
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      FocusScope.of(context).unfocus();

      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .whenComplete(
        () {
          isLoading = false;
          notifyListeners();
          if (currentUserUid.isNotEmpty) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/rootScreen',
              (route) => false,
            );
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // // GOOGLE SIGN IN
  // Future<void> signInWithGoogle(BuildContext context) async {
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //     FocusScope.of(context).unfocus();

  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;

  //     if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
  //       // Create a new credential
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth?.accessToken,
  //         idToken: googleAuth?.idToken,
  //       );
  //       await _auth.signInWithCredential(credential).whenComplete(
  //         () {
  //           isLoading = false;
  //           notifyListeners();
  //           if (currentUserUid.isNotEmpty) {
  //             Navigator.pushNamedAndRemoveUntil(
  //               context,
  //               '/rootScreen',
  //               (route) => false,
  //             );
  //           }
  //         },
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     showSnackBar(context, e.message!); // Displaying the error message
  //   } catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     showSnackBar(context, e.toString());
  //   }
  // }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      FocusScope.of(context).unfocus();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await _auth.signInWithCredential(credential).whenComplete(
          () async {
            isLoading = false;
            notifyListeners();
            if (currentUserUid.isNotEmpty) {
              // Call saveUser to save the user's information to Firestore
              await saveUser(
                googleUser?.displayName ??
                    "", // Assuming you can get the user's name from Google Sign-In
                googleUser?.email ??
                    "", // Assuming you can get the user's email from Google Sign-In
              );
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/rootScreen',
                  (route) => false,
                );
              }
            }
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      showSnackBar(context, e.message!); // Displaying the error message
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showSnackBar(context, e.toString());
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut().whenComplete(
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              '/signIn',
              (route) => false,
            ),
            // () => AuthRepository.materialNavigatorKey.currentState!.popUntil(
            //   (route) => route.isFirst,
            // ),
          );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  Future<void> saveUser(String name, String email) async {
    try {
      final User? currentUser = _auth.currentUser;

      // Check if the user is signed in
      if (currentUser != null) {
        final userRef = FirebaseFirestore.instance.collection('users');

        // Create a document with the user's UID as the document ID
        await userRef.doc(currentUser.uid).set({
          'name': name,
          'email': email,
        });

        // User information has been saved to Firestore
        print('User information saved to Firestore');
      } else {
        // User is not signed in, handle accordingly
        print('User is not signed in');
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error saving user information: $e');
    }
  }
}
