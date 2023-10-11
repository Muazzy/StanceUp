import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fyp/firebase_options.dart';
import 'package:fyp/provider/video_provider.dart';
import 'package:fyp/screens/sign_in_screen.dart';
import 'package:fyp/screens/sign_up_screen.dart';
import 'package:fyp/services/auth_repository.dart';
import 'package:fyp/utils/app_theme.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';
import 'home_screen.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthRepository(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider(
          create: (context) => VideoProvider(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthRepository>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(cameras: cameras),
        //home: MainScreen(cameras),
        theme: AppTheme().lightTheme,
        routes: {
          MainScreen.id: (context) => MainScreen(cameras),
          '/signIn': (context) => const SignInScreen(),
          '/signUp': (context) => const SignUpScreen(),
          '/rootScreen': (context) => HomeScreen(cameras),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key, required this.cameras}) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      initialData: null,
      stream: context.watch<AuthRepository>().authState,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //
        if (snapshot.hasData) {
          return HomeScreen(cameras);
        } else if (snapshot.hasError) {
          return const ScaffoldMessenger(
            child: SnackBar(
              content: Text('Something went wrong'),
            ),
          );
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
