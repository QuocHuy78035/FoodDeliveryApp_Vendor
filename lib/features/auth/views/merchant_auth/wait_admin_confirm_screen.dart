import 'package:ddnangcao_project/features/auth/views/merchant_auth/login_screen.dart';
import 'package:flutter/material.dart';

class WaitAdminConfirmScreen extends StatelessWidget {
  const WaitAdminConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Please wait for admin approve your account!",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text("Back to login"),
            )
          ],
        ),
      ),
    );
  }
}
