import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileIO {
  static FileIO _instance = FileIO._internal();

  factory FileIO() {
    return _instance;
  }

  FileIO._internal();

  /// get right directory
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// reference to receipt file location
  Future<File> getReceiptsFile() async {
    final path = await _localPath;
    return File('$path/receipts.js');
  }

  /// reference to receipt file location
  Future<File> getSteeringFile() async {
    final path = await _localPath;
    return File('$path/steerings.js');
  }

  /// write receipts string to file
  Future<File> writeString(String json, Future<File> f) async {
    final file = await f;
    print('write json to device');
    return file.writeAsString(json);
  }

  /// read data from receipts file
  Future<String> readString(Future<File> f) async {
    try {
      final file = await f;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      print('Could not read the json from storage! ErrorTxt: ${e.toString()}');
      return "";
    }
  }
}
