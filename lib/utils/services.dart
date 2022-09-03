// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http; //No internet connection required so just comment this
// import './cfg_environment.dart';

// //model
// import '../models/http_exceptions.dart';

// class Services {
//   final String _baseUrl = CfgEnvironment.baseUrl;

//   Map<String, String> _renderHeader({
//     dynamic uploadFile,
//     // String token,
//   }) {
//     return {
//       "Content-Type":
//           uploadFile != null ? "multipart/form-data" : "application/json",
//       // "Authorization": token != null ? "Bearer $token" : null, //firebase using token in query parameter
//     };
//   }

//   Map<String, dynamic> _response(http.Response resp) {
//     return {
//       'headers': resp.headers,
//       'body': json.decode(resp.body),
//       'statusCode': resp.statusCode,
//     };
//   }

//   Future<dynamic> post({
//     String? customBaseUrl,
//     required String path,
//     required dynamic body,
//     String? token,
//     String? userId,
//     dynamic uploadFile,
//   }) {
//     return http
//         .post(
//           Uri.parse('${customBaseUrl ?? _baseUrl}/$path'),
//           headers: _renderHeader(),
//           body: json.encode(body),
//         )
//         .then((resp) => _response(resp))
//         .catchError(
//       (error) {
//         debugPrint(error);
//         throw HttpException(
//             'Could not run POST operation, something wrong with http request | exception: $error');
//       },
//     );
//   }

//   Future<dynamic> get({
//     String? customBaseUrl,
//     required String path,
//     String? token,
//     String? userId,
//   }) {
//     return http
//         .get(
//           Uri.parse('${customBaseUrl ?? _baseUrl}/$path'),
//           headers: _renderHeader(),
//         )
//         .then((resp) => _response(resp))
//         .catchError((error) {
//       debugPrint(error);
//       throw HttpException(
//           'Could not run GET operation, something wrong with http request | exception: $error');
//     });
//   }

//   Future<dynamic> patch({
//     String? customBaseUrl,
//     required String path,
//     required dynamic body,
//     String? token,
//     String? userId,
//     dynamic uploadFile,
//   }) {
//     return http
//         .patch(
//           Uri.parse('${customBaseUrl ?? _baseUrl}/$path'),
//           headers: _renderHeader(),
//           body: json.encode(body),
//         )
//         .then((resp) => _response(resp))
//         .catchError((error) {
//       debugPrint(error);
//       throw HttpException(
//           'Could not run PATCH operation, something wrong with http request | exception: $error');
//     });
//   }

//   Future<dynamic> put({
//     String? customBaseUrl,
//     required String path,
//     required dynamic body,
//     String? token,
//     String? userId,
//     dynamic uploadFile,
//   }) {
//     return http
//         .put(
//           Uri.parse('${customBaseUrl ?? _baseUrl}/$path'),
//           headers: _renderHeader(),
//           body: json.encode(body),
//         )
//         .then((resp) => _response(resp))
//         .catchError((error) {
//       debugPrint(error);
//       throw HttpException(
//           'Could not run PATCH operation, something wrong with http request | exception: $error');
//     });
//   }

//   Future<dynamic> delete({
//     String? customBaseUrl,
//     required String path,
//     String? token,
//     String? userId,
//   }) {
//     return http
//         .delete(
//           Uri.parse('${customBaseUrl ?? _baseUrl}/$path'),
//           headers: _renderHeader(),
//         )
//         .then((resp) => _response(resp))
//         .catchError((error) {
//       debugPrint(error);
//       throw HttpException(
//           'Could not run DELETE operation, something wrong with http request | exception: $error');
//     });
//   }
// }
