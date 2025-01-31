import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/widgets/custom_formatting_text.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f3f7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFf2f3f7).withAlpha(0),
        leading: GestureDetector(
          child: Icon(
            Icons.chevron_left,
            size: 32.0,
            color: Colors.black.withAlpha(60),
          ),
          onTap: () => context.go(
            '/home_page',
            extra: true, //replace active page, didn't make stack buildup
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: TextButton(
              onPressed: () {
                // Aksi simpan catatan
              }, // Warna ikon agak gelap
              style: TextButton.styleFrom(
                backgroundColor: Colors.black.withAlpha(9), // Transparan hitam
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
