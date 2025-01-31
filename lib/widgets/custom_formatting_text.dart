import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/providers/text_formatting_provider.dart';

// enum TextFormatting { bold, italic, justify, list }

class TextFormattingToolbar extends ConsumerWidget {
  const TextFormattingToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedFormat = ref.watch(textFormattingProvider);
    var formatNotifier = ref.read(textFormattingProvider.notifier);

    return Card(
      color: Colors.white.withAlpha(150),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SegmentedButton<TextFormatting>(
        segments: [
          ButtonSegment(
            value: TextFormatting.bold,
            icon: Icon(Icons.format_bold_sharp),
          ),
          ButtonSegment(
            value: TextFormatting.italic,
            icon: Icon(Icons.format_italic_sharp),
          ),
          ButtonSegment(
            value: TextFormatting.justify,
            icon: Icon(Icons.format_align_justify),
          ),
          ButtonSegment(
            value: TextFormatting.list,
            icon: Icon(Icons.format_list_bulleted_sharp),
          ),
        ],
        selected: selectedFormat,
        onSelectionChanged: (newSelection) {
          if (newSelection.isNotEmpty) {
            formatNotifier.toggleFormat(newSelection.first);
          } else {
            formatNotifier.toggleFormat(TextFormatting.same);
          }
        },
        showSelectedIcon: false,
        emptySelectionAllowed: true,
        multiSelectionEnabled: true,
      ),
    );
  }
}
