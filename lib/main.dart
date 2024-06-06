import 'dart:async';

import 'package:chef_lanch_admin/firebase_options.dart';
import 'package:chef_lanch_admin/providers/home_provider.dart';
import 'package:chef_lanch_admin/providers/menu_provider.dart';
import 'package:chef_lanch_admin/providers/order_provider.dart';
import 'package:chef_lanch_admin/providers/pages_proveder.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

ValueNotifier<bool> isDeviceConnected = ValueNotifier(false);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? sub;
  Future<void> getConnectivity() async {
    isDeviceConnected.value = await InternetConnectionChecker().hasConnection;
  }

  @override
  void initState() {
    getConnectivity();
    sub = Connectivity().onConnectivityChanged.listen((result) async {
      await getConnectivity();
    });
    super.initState();
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PagesProvider(),
      ),
    );
  }
}
