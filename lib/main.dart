import 'package:flutter/material.dart';
import 'package:onlineshopping/authentication/screen/login.dart';
import 'package:onlineshopping/authentication/screen/user_register.dart';
import 'package:onlineshopping/navigation_bar.dart';
import 'package:onlineshopping/utils/theme/theme.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const UserRegisterScreen(),
        '/home': (_) => const Home(),
      },
    );
  }
}
