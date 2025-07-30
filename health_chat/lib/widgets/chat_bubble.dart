import 'package:flutter/material.dart';
import 'package:health_chat/theme/app_color.dart';

class ChatBubble extends StatelessWidget {

  final String text;
  final bool isUser;
  const ChatBubble({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final userBubbleColor = isDarkMode ? AppColors.darkSecondary : AppColors.lightPrimary;
    final botBubbleColor = theme.cardColor;
    final bubbleColor = theme.cardColor;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0) ,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? userBubbleColor : botBubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
            bottomLeft: isUser ? const Radius.circular(20.0) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(20.0),

          )
        ),

        child: Text(
          text,
          style: TextStyle(color: isUser ? Colors.white : theme.textTheme.bodyLarge?.color),
        ),
      ),
    );
  }
}
