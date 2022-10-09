import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

Future<File> writeCounter(int counter) async {
  final file = await File('assets/userInfo.txt');

  // Write the file
  return file.writeAsString('$counter');
}
