
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class SoundController {
  static Future<void> startRecording() async {
    final tempDir = await getExternalStorageDirectory();
    print(tempDir);
    Record.start(path: '${tempDir.path}/record_tmp.acc');
  }

  static Future<void> stopRecording() async {
     Record.stop();
  }

  static Future<bool> get isRecording => Record.isRecording();
}
