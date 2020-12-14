import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:voicehelp/client/record_client.dart';
import 'package:voicehelp/common/constants.dart';

Future<Response> uploadRecord(String _recordName) async {
  final CreateRecordFileRequest recordFileRequest =
      CreateRecordFileRequest('aac');
  final CreateRecordRequest recordRequest =
      CreateRecordRequest(_recordName, recordFileRequest);

  return createRecord(recordRequest);
}

void removeRecordFile() async {
  var recordPathDir = await getExternalStorageDirectory();
  var recordPath =
      recordPathDir.path + '/' + RecordConstants.LAST_RECORD_FILE_NAME;
  File(recordPath).delete();
}

Future<List<RecordResponse>> getRecords(){
  return getAllRecords();
}

Future<Response> getRecordFile(String recordId){
  return downloadRecordFile(recordId);
}

Future<String> getRecordFilePath(String recordId) async{
  var recordPathDir = await getExternalStorageDirectory();
  var recordPath = recordPathDir.path + '/' + recordId + ".aac";
  return recordPath;
}

Future<http.Response> addRecordRating(String recordId, int rating){
  return createRating(new CreateRecordRating(recordId, rating));
}