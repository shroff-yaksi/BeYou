import 'dart:async';
import 'package:flutter/material.dart';

/// A [ChangeNotifier] that re-notifies listeners whenever a stream emits.
/// Used to make GoRouter re-evaluate its redirect function on auth state changes.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
