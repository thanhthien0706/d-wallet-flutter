import 'dart:convert';
import 'dart:io';

import 'package:cn1_d_wallet/common/constant/app_endpoint.dart';
import 'package:cn1_d_wallet/common/values/share-key.dart';
import 'package:cn1_d_wallet/models/file-model.dart';
import 'package:cn1_d_wallet/services/bases/header-endpoint.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import 'auth-service.dart';

class FilesService {
  final BuildContext? context;
  final SharedPreferences? prefs;

  FilesService({this.context, this.prefs});

  Future<FileModel?> uploadFile(File file) async {
    try {
      String extension = path.extension(file.path);
      String fileType = extension.substring(1);
      Uri url = Uri.parse(AppEndpoint.filesEndpoint);

      final request = http.MultipartRequest("POST", url);

      request.headers["authorization"] =
          "Bearer ${prefs!.getString(ShareKey.ACCESS_TOKEN)}";
      request.files.add(await http.MultipartFile.fromPath('file', file.path,
          contentType: MediaType("image", fileType)));

      final response = await request.send();

      final responseString = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseString) as Map<String, dynamic>;

      if (response.statusCode == 401) {
        bool? refreshToken = await AuthService(context: context!, prefs: prefs!)
            .getRefreshToken();
        refreshToken! ? uploadFile(file) : null;

        return null;
      }

      if (response.statusCode == 201) {
        final imageUploadResponse = FileModel.fromJson(jsonResponse);
        return imageUploadResponse;
      }
    } catch (e) {
      print("Error : $e");
    }
  }
}
