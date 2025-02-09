import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'presentation/app.dart';
import 'injection_container.dart';

void main() async {
  await initializeDependencies();
  runApp(const GutenbergApp());
}