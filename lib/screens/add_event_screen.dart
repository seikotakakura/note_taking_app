import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends ConsumerWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController titleEventController = TextEditingController();
    TextEditingController descEventController = TextEditingController();
    bool isAllDay = false;
    String dateTodayMulai = DateFormat("d MMM yyyy").format(DateTime.now());
    String timeTodayMulai = DateFormat("HH:mm").format(DateTime.now());
    String dateTodaySelesai = DateFormat("d MMM yyyy").format(DateTime.now());
    String timeTodaySelesai = DateFormat("HH:mm").format(DateTime.now().add(Duration(hours: 1)));

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // Border di Dialog
      ),
      child: Material( //Handling keyboard problem when testing on macos
        child: Container(
          color: Color(0xFFF4F4F4),
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
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
                            Icons.close,
                            size: 20.0,
                            color: Colors.black.withAlpha(200),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                    SizedBox(
                      child: Text(
                        "Tambah Event",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFB9E3C6),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(width: 1),
                          ),
                          child: Icon(
                            Icons.save_outlined,
                            size: 20.0,
                            color: Colors.black.withAlpha(200),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleEventController,
                      autofocus: true,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Event',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    Divider(),
                    Flexible(
                      child: TextFormField(
                        controller: descEventController,
                        decoration: InputDecoration(
                          hintText: "Write your description here...",
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500,
                        ),
                        // keyboardType: TextInputType.multiline,
                        maxLines: 3,
                      ),
                    ),
                    Divider(),
                    Flexible(
                      child: Column(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Seharian",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 11.0,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 30,
                                  height: 20,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Switch(
                                      value: isAllDay,
                                      activeColor: Color(0xFFB9E3C6),
                                      inactiveTrackColor: Color(0xFFF4F4F4),
                                      onChanged: (bool value) {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mulai",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 11.0,
                                  ),
                                ),
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF4F4F4),
                                            border: Border.all(),
                                          ),
                                          child: Text(
                                            dateTodayMulai,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 9.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 2.0),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF4F4F4),
                                            border: Border.all(),
                                          ),
                                          child: Text(
                                            timeTodayMulai,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 9.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Selesai",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 11.0,
                                  ),
                                ),
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF4F4F4),
                                            border: Border.all(),
                                          ),
                                          child: Text(
                                            dateTodaySelesai,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 9.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 2.0),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF4F4F4),
                                            border: Border.all(),
                                          ),
                                          child: Text(
                                            timeTodaySelesai,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 9.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
