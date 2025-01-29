import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_taking_app/data/dummy_data.dart';

class AllListData extends StatelessWidget {
  const AllListData({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyData = DummyData();

    return Expanded(
      // height: MediaQuery.of(context).size.height * 1/1.804,
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: 80.0), 
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, // Maksimal lebar tiap item
          // mainAxisExtent: randomHeight, // Maksimal lebar tiap item
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 0.9,
        ),
        itemCount: dummyData.dummyNotes.length,
        itemBuilder: (context, index) {
          // final double randomOverflow = Random().nextInt(7) + 4;
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // height: randomHeight,
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
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // color: Colors.yellow,
                    alignment: Alignment.topLeft,
                    child: Text(
                      dummyData.dummyNotes[index].title,
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
                      // color: Colors.blue,
                      alignment: Alignment.topLeft,
                      child: Text(
                        dummyData.dummyNotes[index].content,
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
          );
        },
      ),
    );
  }
}
