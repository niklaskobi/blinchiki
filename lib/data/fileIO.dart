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

  /// reference to file location
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/receipts.js');
  }

  /// write string to file
  Future<File> writeString(String json) async {
    final file = await _localFile;
    print('writeString: $json');

    return file.writeAsString(json);
  }

  /// read data from file
  Future<String> readString() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return 'Could not read the json from storage! ErrorTxt: ${e.toString()}';
    }
  }
}
