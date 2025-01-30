import 'package:flutter/material.dart';
import 'package:furry_flutter/features/dashboard/presentation/dashboard_screen.dart';
import 'package:furry_flutter/features/store_items/domain/store_item.dart';
import 'package:furry_flutter/features/store_items/store_item_detail_screen.dart';
import 'package:furry_flutter/features/my_friends/domain/my_friend.dart';
import 'package:furry_flutter/features/my_friends/presentation/my_friend_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => DashboardScreen(),
    ),
    GoRoute(
      path: '/my-friend',
      builder: (context, state) => MyFriendDetailScreen(friend: state.extra as MyFriend),
    ),
    GoRoute(
      path: '/item',
      builder: (context, state) => ItemDetailScreen(item: state.extra as StoreItem),
    ),
  ],
  errorBuilder: ((context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Not Available'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'This feature is not yet available',
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      )),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF3B5BA4)),
        searchBarTheme: SearchBarThemeData(
          elevation: WidgetStatePropertyAll(1.0),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
