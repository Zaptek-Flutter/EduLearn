// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailorusernameProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

class SignInForm extends ConsumerWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);

    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Email or Username',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/icons/user.png',
                width: 24,
                height: 24,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onChanged: (value) =>
              ref.read(emailorusernameProvider.notifier).state = value,
        ),
        const SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/icons/password.png',
                width: 24,
                height: 24,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                ref.read(passwordVisibilityProvider.notifier).state =
                    !isPasswordVisible;
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          obscureText: !isPasswordVisible, 
          onChanged: (value) =>
              ref.read(passwordProvider.notifier).state = value,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
