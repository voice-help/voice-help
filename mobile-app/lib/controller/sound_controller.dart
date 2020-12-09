
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:voicehelp/common/constants.dart';

class SoundController {


  static Future<void> startRecording() async {
    final tempDir = await getExternalStorageDirectory();
    print(tempDir);
    Record.start(path: '${tempDir.path}/'+RecordConstants.LAST_RECORD_FILE_NAME);
  }

  static Future<void> stopRecording(Function _onStopRecord) async {
     Record.stop();
     _onStopRecord();
  }

  static Future<bool> get isRecording => Record.isRecording();
}
