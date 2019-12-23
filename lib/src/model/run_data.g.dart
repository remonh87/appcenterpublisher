// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_data.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $RunData {
  ApiConfig get config;
  AppRelease get release;
  DistributionGroup get group;
  String get artefactLocation;
  const $RunData();
  RunData copyWith({ApiConfig config, AppRelease release, DistributionGroup group, String artefactLocation}) => RunData(
      config: config ?? this.config,
      release: release ?? this.release,
      group: group ?? this.group,
      artefactLocation: artefactLocation ?? this.artefactLocation);
  String toString() =>
      "RunData(config: $config, release: $release, group: $group, artefactLocation: $artefactLocation)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      config == other.config &&
      release == other.release &&
      group == other.group &&
      artefactLocation == other.artefactLocation;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + config.hashCode;
    result = 37 * result + release.hashCode;
    result = 37 * result + group.hashCode;
    result = 37 * result + artefactLocation.hashCode;
    return result;
  }
}

class RunData$ {
  static final config = Lens<RunData, ApiConfig>((s_) => s_.config, (s_, config) => s_.copyWith(config: config));
  static final release = Lens<RunData, AppRelease>((s_) => s_.release, (s_, release) => s_.copyWith(release: release));
  static final group = Lens<RunData, DistributionGroup>((s_) => s_.group, (s_, group) => s_.copyWith(group: group));
  static final artefactLocation = Lens<RunData, String>(
      (s_) => s_.artefactLocation, (s_, artefactLocation) => s_.copyWith(artefactLocation: artefactLocation));
}
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: always_require_non_null_named_parameters
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: join_return_with_assignment
// ignore_for_file: prefer_asserts_with_message
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: prefer_single_quotes
// ignore_for_file: sort_constructors_first
// ignore_for_file: type_annotate_public_apis
