import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/pages/home_page.dart';
import 'package:shopping_app/providers/product_cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      // enabling to storing data to root of tree widget
      // that means every widget now can have access with data in CartProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // we are using multiprovider, because in the bigger apps, we will have more than 1 provider class
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        fontFamily: 'Lato',
        // will generate some color scheme from seed
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(254, 206, 1, 1),
          primary: const Color.fromRGBO(254, 206, 1, 1),
        ),
        // create theme for reuseability
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
  