import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/providers/tab_providers.dart';

class CustomTabBar extends ConsumerWidget {
  CustomTabBar({super.key});

  final List<String> tabs = ["All", "Task", "Notes", "Events", "More"];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTabProvider);

    return SizedBox(
      height: 30.0,
      // width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        // physics: BouncingScrollPhysics(),
        // shrinkWrap: true,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: GestureDetector(
              onTap: () => ref.read(selectedTabProvider.notifier).state = index,
              child: Container(
                // width: 70.0,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFFfe6802) : Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontFamily: 'Noto_Serif',
                    color: isSelected ? Colors.black : Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
