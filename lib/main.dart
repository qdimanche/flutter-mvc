import 'package:flutter/material.dart';
import 'package:form/screens/home_screen.dart';
import 'package:form/screens/register_screen.dart';
import 'package:form/screens/user_list_screen.dart';

void main() {
  runApp(const MainApp());
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
      },
    );
  }
}