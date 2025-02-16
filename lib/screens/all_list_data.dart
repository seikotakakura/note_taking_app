import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:note_taking_app/data/dummy_data.dart';
import 'package:note_taking_app/providers/note_provider.dart';

class AllListData extends ConsumerWidget {
  const AllListData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final dummyData = DummyData();
    final notesState = ref.watch(notesProvider);

    return notesState.when(
      data: (notes) => notes.isEmpty
          ? Center(child: Text("Belum ada catatan"))
          : Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: 80.0),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 0.9,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => context.go('/new_note_page', extra: notes[index]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.3),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                notes[index].title,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  notes[index].content,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text("Terjadi kesalahan")),
    );
  }
}
