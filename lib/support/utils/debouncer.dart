import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration duration;
  Timer? timer;

  Debouncer({required this.duration});

  Future<void> run({required VoidCallback action}) async {
    timer?.cancel();

    timer = Timer(duration, action);
  }
}
