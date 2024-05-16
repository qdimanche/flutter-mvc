import 'package:flutter/material.dart';
import 'package:form/screens/home_screen.dart';
import 'package:form/screens/login_screen.dart';
import 'package:form/screens/profile_screen.dart';
import 'package:form/screens/register_screen.dart';
import 'package:form/screens/user_list_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MainApp(),
    ),
  );
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/user_list': (context) => const UserListScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/profile': (context) => const ProfileScreen()
      },
    );
  }
}