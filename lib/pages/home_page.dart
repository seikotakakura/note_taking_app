import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/providers/quote_provider.dart';
import 'package:note_taking_app/screens/all_list_data.dart';
import 'package:note_taking_app/widgets/custom_tab_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quoteAsyncValue = ref.watch(quoteProvider);

    return Scaffold(
      backgroundColor: Color(0xFFf2f3f7),
      appBar: AppBar(
        title: Text(
          'ProdNote',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Merriweather',
            color: Colors.black,
            fontSize: 24.0,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.search_rounded,
                size: 32.0,
              ),
            ),
            onTap: () {},
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            //Random Quotes
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: quoteAsyncValue.when(
                data: (quote) => Container(
                  width: MediaQuery.of(context).size.width,
                  // height: double.infinity,
                  height: MediaQuery.of(context).size.height * 1 / 4.5,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFc9f46a),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '"${quote.quote}"',
                        style: const TextStyle(
                          fontFamily: 'Noto_Serif',
                          fontSize: 15.0,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          quote.author,
                          style: const TextStyle(
                            fontFamily: 'Noto_Serif',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                error: (error, stack) => Text('Error: $error'),
                loading: () => CircularProgressIndicator(),
              ),
            ),
            const SizedBox(height: 8.0),

            //Custom Tab Bar
            CustomTabBar(),
            const SizedBox(height: 8.0),
            //dummy all data
            AllListData(),
          ],
        ),
      ),
    );
  }
}
