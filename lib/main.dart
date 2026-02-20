import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_firebase/firebase_options.dart';
import 'package:pos_firebase/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'controllers/auth_controller.dart';
import 'controllers/home_controller.dart';
import 'core/theme/app_theme.dart';
import 'screens/auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 600, name: MOBILE),
            Breakpoint(start: 601, end: 1024, name: TABLET),
            Breakpoint(start: 1025, end: 1920, name: DESKTOP),
          ],
        ),
        home: Consumer<AuthController>(
          builder: (context, authController, child) {
            if (authController.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return HomeScreen();
                  } else {
                    return const LoginScreen();
                  }
                }
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
