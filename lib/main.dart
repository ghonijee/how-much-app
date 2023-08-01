import 'package:app_ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/gen/injection/injection.dart';
import 'package:how_much/presentation/router/app_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initial Injection
  configureDependencies();
  runApp(ProviderScope(child: InitialApp()));
}

class InitialApp extends StatelessWidget {
  InitialApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        title: 'How Much',
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
      );
    });
  }
}
