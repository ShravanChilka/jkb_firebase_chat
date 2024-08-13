import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jkb_firebase_chat/modules/chat/bloc/chat_bloc.dart';

class PickImageIconButton extends StatelessWidget {
  const PickImageIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {
          final ImagePicker picker = ImagePicker();
          picker.pickImage(source: ImageSource.gallery).then((xFile) {
            final path = xFile?.path;
            if (path == null) return;
            context.read<ChatBloc>().add(
                  ChatEventSendImage(path: path),
                );
          });
        },
        icon: const Icon(Icons.add),
      ),
    );
  }
}
