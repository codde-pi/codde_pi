import 'package:flutter/material.dart';

class NewsletterRegistration extends StatelessWidget {
  final emailController = TextEditingController();

  NewsletterRegistration({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Join the newsletter'),
      content: TextField(
        controller: emailController,
        decoration: const InputDecoration(hintText: "Email"),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('OK'),
        ),
      ],
    );
  }
}
