import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter/my_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            localStorage.setItem('auth', true);
            context.go('/');
          },
          child: const Text('登录'),
        ),
      ),
    );
  }
}
