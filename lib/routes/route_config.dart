import 'package:crypto_price_tracker_web_app/view/crypto_view.dart';
import 'package:crypto_price_tracker_web_app/view/initial_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/error_view.dart';
import 'route_names.dart';

class RouteConfig {
  static GoRouter returnRouter() {
    return GoRouter(
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
          name: RouteNames.initial,
          pageBuilder: (context, state) => MaterialPage(child: InitialView()),
        ),
        GoRoute(
          path: "/crypto/:coin",
          name: RouteNames.cryptoView,
          builder: (context, state) {
            final coin = state.pathParameters["coin"];
            return CryptoView(
              coin: coin ?? "BTC",
            );
          },
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage(
        child: ErrorView(),
      ),
    );
  }
}
