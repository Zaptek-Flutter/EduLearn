// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fullNameProvider = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final confirmPasswordProvider = StateProvider<String>((ref) => '');
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
final confirmPasswordVisibilityProvider = StateProvider<bool>((ref) => false);

class SignUpForm extends ConsumerWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final isConfirmPasswordVisible = ref.watch(confirmPasswordVisibilityProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name Field
        TextField(
          decoration: InputDecoration(
            labelText: 'Full Name',
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
              ref.read(fullNameProvider.notifier).state = value,
        ),
        const SizedBox(height: 20),

        // Email Field
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/icons/email.png',
                width: 24,
                height: 24,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onChanged: (value) =>
              ref.read(emailProvider.notifier).state = value,
        ),
        const SizedBox(height: 20),

        // Password Field
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

        // Confirm Password Field
        TextField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
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
                isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                ref.read(confirmPasswordVisibilityProvider.notifier).state =
                    !isConfirmPasswordVisible;
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          obscureText: !isConfirmPasswordVisible,
          onChanged: (value) =>
              ref.read(confirmPasswordProvider.notifier).state = value,
        ),
        const SizedBox(height: 20),

      ],
    );
  }
}
