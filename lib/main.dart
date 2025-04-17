import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'routes/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  initialization().then((_) => FlutterNativeSplash.remove());
  runApp(const MainApp());
}

Future<void> initialization() async {
  await Future.delayed(const Duration(seconds: 1)); 
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    if (kIsWeb) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fourier Forge',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const WebContainer(child: AppContent()),
      );
    }
    
    
    return const AppContent();
  }
}

class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fourier Forge',
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

class WebContainer extends StatelessWidget {
  final Widget child;
  
  const WebContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;
    
    
    if (size.width < 500) {
      return child;
    }
    

    return Scaffold(
      body: Center(
        child: Container(
          width: 375, // iPhone width
          height: 812, // iPhone height
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                spreadRadius: 5,
              )
            ],
          ),
          clipBehavior: Clip.antiAlias, 
          child: child,
        ),
      ),
    );
  }
}