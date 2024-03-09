import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/crypto_bloc/crypto_bloc.dart';
import 'routes/route_config.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => CryptoBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouteConfig.returnRouter(),
      debugShowCheckedModeBanner: false,
      title: 'Crypto price tracking web app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: BlocProvider(
      //   create: (context) => CryptoBloc(),
      //   child: const HomeView(),
      // ),
    );
  }
}
