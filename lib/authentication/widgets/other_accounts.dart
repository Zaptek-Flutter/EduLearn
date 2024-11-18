import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedAccountProvider = StateProvider<String>((ref) => '');

class OtherAccounts extends ConsumerWidget {
  const OtherAccounts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final selectedAccount = ref.watch(selectedAccountProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google Button
        _AccountButton(
          icon: 'assets/icons/google.png',
          onPressed: () {
            ref.read(selectedAccountProvider.notifier).state = 'Google';
            _showSnackbar(context, 'Google account selected');
          },
        ),
        const SizedBox(width: 16),
        // Facebook Button
        _AccountButton(icon: "assets/icons/facebook.png", onPressed: (){
          ref.read(selectedAccountProvider.notifier).state = 'Facebook';
          _showSnackbar(context, 'Facebook account selected');
        }),
        const SizedBox(width: 16,),
        // Twitter (X) Button
        _AccountButton(
          icon: 'assets/icons/x.png',
          onPressed: () {
            ref.read(selectedAccountProvider.notifier).state = 'Twitter';
            _showSnackbar(context, 'Twitter (X) account selected');
          },
        ),
        const SizedBox(width: 16),
        // LinkedIn Button
        _AccountButton(
          icon: 'assets/icons/linkedin.png',
          onPressed: () {
            ref.read(selectedAccountProvider.notifier).state = 'LinkedIn';
            _showSnackbar(context, 'LinkedIn account selected');
          },
        ),
      ],
    );
  }

  // Function to show a simple snackbar message
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _AccountButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const _AccountButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              offset: const Offset(-4, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Image.asset(
          icon,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
