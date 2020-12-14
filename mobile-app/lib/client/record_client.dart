import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicehelp/common/constants.dart';
import 'package:voicehelp/config.dart';
import 'package:http/http.dart' as http;


Future<Response> createRecord(CreateRecordRequest createRecordRequest) async {
  var appConfig = await AppConfig.getConfig();
  var recordPathDir = await getExternalStorageDirectory();
  var recordPath =
      recordPathDir.path + '/' + RecordConstants.LAST_RECORD_FILE_NAME;

  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(recordPath),
    "name": createRecordRequest._recordName,
    "extension": createRecordRequest._recordFileRequest._extension
  });

  var preferencesFuture = await SharedPreferences.getInstance();
  var accessToken = preferencesFuture.get(appConfig.accessTokenKey);

  Dio dio = Dio(
    BaseOptions(contentType: 'multipart/form-data', headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    }),
  );

  return await dio.post(appConfig.recordUploadUrl, data: formData,
      onSendProgress: (int send, int total) {
    print((send / total) * 100);
  });
}

Future<List<RecordResponse>> getAllRecords() async {
  var appConfig = await AppConfig.getConfig();
  var preferencesFuture = await SharedPreferences.getInstance();
  var accessToken = preferencesFuture.get(appConfig.accessTokenKey);
  Dio dio = Dio(BaseOptions(headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $accessToken'
  }));
  var allRecordUrl = appConfig.allRecordUrl;
  var parameters = {'sortBy': 'createDate', 'sortDirection': 'desc'};
  allRecordUrl = _resolveUrlParameters(allRecordUrl, parameters);
  var response = await dio.get(allRecordUrl);
  var records = response.data["records"] = (response.data['records'] as List)
      ?.map((e) => e == null ? null : Map<String, dynamic>.from(e))
      ?.toList();
  return records.map((i) => RecordResponse.fromJson(i)).toList();
}

Future<Response> downloadRecordFile(String recordId) async {
  var appConfig = await AppConfig.getConfig();
  var preferencesFuture = await SharedPreferences.getInstance();
  var accessToken = preferencesFuture.get(appConfig.accessTokenKey);
  Dio dio = new Dio(BaseOptions(
      headers: <String, String>{'Authorization': 'Bearer $accessToken'}));
  var recordPathDir = await getExternalStorageDirectory();
  var recordPath = recordPathDir.path + '/' + recordId + ".aac";
  var response = await dio.download(
      appConfig.allRecordUrl + "/" + recordId + "/file", recordPath);
  return response;
}

Future<http.Response> createRating(CreateRecordRating dto) async{
  var appConfig = await AppConfig.getConfig();

  var preferencesFuture = await SharedPreferences.getInstance();
  var accessToken = preferencesFuture.get(appConfig.accessTokenKey);

     var post = await http
      .post(appConfig.recordRatingUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(dto.toJson()));
}

String _resolveUrlParameters(String url, Map<String, String> parameters) {
  url += "?";
  parameters.forEach((key, value) {
    url += key;
    url += "=";
    url += value;
    url += "&";
  });

  return url;
}

class RecordResponse {
  final String _recordId;
  final String _recordName;
  final String _recordFileId;
  final double _recordRating;

  RecordResponse(
      this._recordId, this._recordName, this._recordRating, this._recordFileId);

  static RecordResponse fromJson(Map<String, dynamic> json) {
    return RecordResponse(
        json['id'], json['name'], json['rating'], json['file']['id']);
  }

  String get recordFileId => _recordFileId;

  String get recordName => _recordName;

  String get recordId => _recordId;

  double get recordRating => _recordRating;
}

class CreateRecordRequest {
  final String _recordName;
  final CreateRecordFileRequest _recordFileRequest;

  CreateRecordRequest(this._recordName, this._recordFileRequest);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> content = new Map<String, dynamic>();
    content['name'] = this._recordName;
    content['file'] = this._recordFileRequest.toJson();
    return content;
  }
}

class CreateRecordFileRequest {
  final String _extension;

  CreateRecordFileRequest(this._extension);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> content = new Map<String, dynamic>();
    content['extension'] = this._extension;
    return content;
  }
}

class CreateRecordRating{
  final String _recordId;
  final int _rating;

  CreateRecordRating(this._recordId, this._rating);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> content = new Map<String, dynamic>();
    content['recordId'] = this._recordId;
    content['rating'] = this._rating;
    return content;
  }

}
