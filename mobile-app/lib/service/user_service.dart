
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicehelp/config.dart';
import 'package:voicehelp/client/jwt_client.dart';
import 'package:voicehelp/client/user_client.dart';

Future<Response> signIn({String username, String password}) async {
  var appConfig = await AppConfig.getConfig();
  var request = TokenRequest(username: username, password: password);
  var tokenResponse = await fetchToken(config: appConfig, request: request);
  if (tokenResponse.status == 200) {
    SharedPreferences.getInstance().then((instance) => {
          instance.setString(
              appConfig.accessTokenKey, tokenResponse.accessToken),
          instance.setString(
              appConfig.refreshTokenKey, tokenResponse.refreshToken),
        });
    return Response(successfully: true);
  }
  if(tokenResponse.connectionException){
    return Response(successfully: false, failureMessage: 'Cannot sign in - try again later');
  }
  if (tokenResponse.status == 401) {
    return Response(
        successfully: false, failureMessage: 'Wrong username or password');
  }
  return Response(
      successfully: false, failureMessage: 'Cannot sign in - please try later');
}

Future<bool> isSignIn() async {
  var appConfig = await AppConfig.getConfig();
  var preferencesFuture = SharedPreferences.getInstance();

  var prefernces = await preferencesFuture;
  var isTokenExists = prefernces.containsKey(appConfig.accessTokenKey);
  if (!isTokenExists) {
    return false;
  }
  var isAccessKeyValid = await preferencesFuture.then((preference) =>
      validateAccessToken(
          config: appConfig,
          accessToken: preference.getString(appConfig.accessTokenKey)));
  if (isAccessKeyValid) {
    return true;
  }
  var refreshTokenResponse = await refreshAccessToken(config: appConfig, refreshToken: prefernces.get(appConfig.accessTokenKey));
  if(refreshTokenResponse.connectionException){
    return false;
  }
  if (refreshTokenResponse.status == 200) {
    SharedPreferences.getInstance().then((instance) => {
          instance.setString(
              appConfig.accessTokenKey, refreshTokenResponse.accessToken),
          instance.setString(
              appConfig.refreshTokenKey, refreshTokenResponse.refreshToken),
        });
    return true;
  }
  return false;
}

Future<Response> signUp(
    {String username, String email, String password}) async {
  var appConfig = await AppConfig.getConfig();
  var request = CreateUserRequest(username, email, password);
  var response = await createUser(config: appConfig, request: request);
  if (response.status == 200) {
    return Response(successfully: true);
  }
  if (response.status == 409) {
    return Response(successfully: false, failureMessage: response.errorMessage);
  }
  return Response(
      successfully: false, failureMessage: 'Cannot sign up - please try later');
}

Future<void> logout() async{
  var appConfig = await AppConfig.getConfig();
  var preferencesFuture = SharedPreferences.getInstance();
  var preferences = await preferencesFuture;
  await preferences.remove(appConfig.accessTokenKey);
  await preferences.remove(appConfig.refreshTokenKey);
}

class Response {
  final bool successfully;
  final String failureMessage;

  Response({this.successfully, this.failureMessage});
}
