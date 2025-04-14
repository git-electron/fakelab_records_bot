import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

part 'build_info_model.freezed.dart';
part 'build_info_model.g.dart';

@freezed
class BuildInfoModel with _$BuildInfoModel {
  factory BuildInfoModel({
    required String version,
  }) = _BuildInfoModel;

  factory BuildInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BuildInfoModelFromJson(json);

  factory BuildInfoModel.fromPubspec(Pubspec pubspec) =>
      BuildInfoModel(version: pubspec.version?.canonicalizedVersion ?? '1.0.0');

  factory BuildInfoModel.retrieve() => BuildInfoModel.fromPubspec(
      Pubspec.parse(File('pubspec.yaml').readAsStringSync()));
}
