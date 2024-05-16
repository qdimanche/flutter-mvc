import 'package:flutter/material.dart';

import '../widgets/forms/register_form.dart';
import '../widgets/layout/myscaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _RegisterScreen();
  }
}

class _RegisterScreen extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const MyScaffold(name: 'Register', body: RegisterForm());
  }
}