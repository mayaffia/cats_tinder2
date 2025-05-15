import 'package:cats_tinder/data/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/cat_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'package:get_it/get_it.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [ChangeNotifierProvider(create: (_) => CatProvider())],
//       child: MyApp(),
//     ),
//   );
// }

final getIt = GetIt.instance; // 2. Инициализировать GetIt

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Настроить DI
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton<CatProvider>(CatProvider(getIt<ApiService>()));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<CatProvider>(),
        ), // 4. Использовать из GetIt
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kototinder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
