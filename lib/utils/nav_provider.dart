import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/pages/calendar_page.dart';
import 'package:note_taking_app/pages/home_page.dart';
import 'package:note_taking_app/pages/new_note_page.dart';
import 'package:note_taking_app/widgets/bottom_nav_bar.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home_page',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavBar(
            currentLocation: state.matchedLocation,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/home_page',
            builder: (context, state) => HomePage(),
          ),
          GoRoute(
            path: '/calendar_page',
            builder: (context, state) => CalendarPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/new_note_page',
        builder: (context, state) => NewNotePage(),
      ),
    ],
  );
});
