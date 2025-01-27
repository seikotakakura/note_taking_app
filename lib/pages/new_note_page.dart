import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () => context.go(
            '/home_page',
            extra: true, //replace active page, didn't make stack buildup
          ),
        ),
        title: Text('Add New Note'),
      ),
      body: Center(
        child: Text('New Note Page'),
      ),
    );
  }
}
