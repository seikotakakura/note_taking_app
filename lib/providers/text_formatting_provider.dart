import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TextFormatting { bold, italic, justify, list, same }

class TextFormattingNotifier extends StateNotifier<Set<TextFormatting>> {
  TextFormattingNotifier() : super({}); //awalnya tidak ada format aktif

  void toggleFormat(TextFormatting format) {
    if (format == TextFormatting.same) {
      state = {...state}..remove(state.first);
    } else {
      // state = {...state}..remove(state.first);
      state = {...state, format};
    }
  }
}

final textFormattingProvider =
    StateNotifierProvider<TextFormattingNotifier, Set<TextFormatting>>(
        (ref) => TextFormattingNotifier());
