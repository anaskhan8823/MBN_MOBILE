import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';

class TawkChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Chat')),
      body: Tawk(
        directChatLink:
            'https://tawk.to/chat/67a0c00c825083258e0f6990/1ij5uscs7',
        visitor: TawkVisitor(
          name: 'User Name', // Optional: Set visitor name/email
          email: 'user@example.com',
        ),
      ),
    );
  }
}
