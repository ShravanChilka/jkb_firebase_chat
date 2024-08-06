import 'package:flutter/material.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onPressed,
      icon: const Icon(Icons.send),
    );
  }
}
