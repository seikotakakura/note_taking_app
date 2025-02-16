import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:note_taking_app/models/result.dart';
import 'package:note_taking_app/providers/note_provider.dart';
import 'package:note_taking_app/widgets/custom_formatting_text.dart';

class NewNotePage extends ConsumerStatefulWidget {
  const NewNotePage({super.key});

  @override
  ConsumerState<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends ConsumerState<NewNotePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late NoteModel noteUpdate;

  @override
  Widget build(BuildContext context) {
    if (GoRouterState.of(context).extra != null) {
      noteUpdate = GoRouterState.of(context).extra as NoteModel;
      _titleController.text = noteUpdate.title;
      _contentController.text = noteUpdate.content;
    } else {
      noteUpdate = NoteModel(title: "", content: "");
    }
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFf2f3f7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFf2f3f7).withAlpha(0),
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: Color(0xFFF6B5C2),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(width: 1),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 32.0,
                color: Colors.black.withAlpha(200),
              ),
            ),
          ),
          onTap: () => context.go(
            '/home_page',
            extra: true, //replace active page, didn't make stack buildup
          ),
        ),
        actions: [
          noteUpdate.title == ""
              ? SizedBox()
              : Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(width: 1),
                  ),
                  child: Center(
                    child: IconButton(
                      iconSize: 16.0,
                      onPressed: () async {
                        final result = await ref
                            .read(notesProvider.notifier)
                            .deleteNote(noteUpdate.id!);

                        if (context.mounted) {
                          if (result.success) {
                            context.go('/home_page', extra: true);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result.message),
                              duration: Duration(seconds: 2),
                              backgroundColor:
                                  result.message.contains("berhasil")
                                      ? Colors.green[300]
                                      : Colors.red[300],
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red[400],
                      ),
                    ),
                  ),
                ),
          SizedBox(width: 4.0),
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Container(
              height: 35.0,
              decoration: BoxDecoration(
                color: Color(0xFFB9E3C6),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(width: 1),
              ),
              child: TextButton(
                onPressed: () async {
                  Result result = Result(false, "");
                  if (noteUpdate.title == "") {
                    result = await ref.read(notesProvider.notifier).addNote(
                          NoteModel(
                            title: _titleController.text,
                            content: _contentController.text,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                        );
                  } else {
                    result = await ref.read(notesProvider.notifier).updateNote(
                          NoteModel(
                            id: noteUpdate.id,
                            title: _titleController.text,
                            content: _contentController.text,
                            createdAt: noteUpdate.createdAt,
                            updatedAt: DateTime.now(),
                          ),
                          noteUpdate.id!,
                        );
                  }

                  if (context.mounted) {
                    _titleController.clear();
                    _contentController.clear();
                    if (result.success) {
                      context.go('/home_page', extra: true);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result.message),
                        duration: Duration(seconds: 3),
                        backgroundColor: result.message.contains("berhasil")
                            ? Colors.green[300]
                            : Colors.red[300],
                      ),
                    );
                  }
                }, // Warna ikon agak gelap
                style: TextButton.styleFrom(
                  backgroundColor:
                      Colors.black.withAlpha(9), // Transparan hitam
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Biar rounded
                  ),
                ),
                child: Text(
                  "SAVE",
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          )
        ],
        title: Text(''),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TextFormattingToolbar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            /** Title Section */
            TextFormField(
              controller: _titleController,
              autofocus: true,
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
                border: InputBorder.none,
              ),
            ),
            Divider(),
            Expanded(
              child: TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: "Write your note here...",
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
