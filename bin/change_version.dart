import 'dart:io';

import 'package:yaml/yaml.dart';

void main() {
  File pubFile = File('pubspec.yaml');
  File versionFile = File('bin/version.dart');
  if (!pubFile.existsSync() || !versionFile.existsSync()) {
    print('no config to write version');
    return;
  }

  try {
    String version = loadYaml(pubFile.readAsStringSync())['version'];
    versionFile.writeAsStringSync("const version = '$version';");
  } catch (e) {
    print(e);
  }
}
