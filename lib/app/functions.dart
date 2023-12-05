import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../domain/model/model.dart';

Future<DeviceInfo> getDeviceInfo() async {
  DeviceInfoPlugin plugin = DeviceInfoPlugin();
  String name = 'unknown';
  String identifier = 'unknown';
  String version = 'unknown';
  try {
    //Android
    if (Platform.isAndroid) {
      var build = await plugin.androidInfo;
      name = '${build.brand} ${build.model}';
      identifier = build.id;
      version = build.version.codename;
    }
    //ios
    if (Platform.isIOS) {
      var build = await plugin.androidInfo;
      name = '${build.brand} ${build.model}';
      identifier = build.id;
      version = build.version.codename;
    }
  } on PlatformException {
    //return default
    return DeviceInfo('name', 'identifier', 'version');
  }
  return DeviceInfo(name, identifier, version);
}
