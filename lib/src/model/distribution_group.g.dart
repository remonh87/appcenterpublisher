// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distribution_group.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $DistributionGroup {
  String get id;
  bool get mandatoryUpdate;
  bool get notifyTesters;
  const $DistributionGroup();
  DistributionGroup copyWith(
          {String id, bool mandatoryUpdate, bool notifyTesters}) =>
      DistributionGroup(
          id: id ?? this.id,
          mandatoryUpdate: mandatoryUpdate ?? this.mandatoryUpdate,
          notifyTesters: notifyTesters ?? this.notifyTesters);
  String toString() =>
      "DistributionGroup(id: $id, mandatoryUpdate: $mandatoryUpdate, notifyTesters: $notifyTesters)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      mandatoryUpdate == other.mandatoryUpdate &&
      notifyTesters == other.notifyTesters;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + mandatoryUpdate.hashCode;
    result = 37 * result + notifyTesters.hashCode;
    return result;
  }
}

class DistributionGroup$ {
  static final id = Lens<DistributionGroup, String>(
      (s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final mandatoryUpdate = Lens<DistributionGroup, bool>(
      (s_) => s_.mandatoryUpdate,
      (s_, mandatoryUpdate) => s_.copyWith(mandatoryUpdate: mandatoryUpdate));
  static final notifyTesters = Lens<DistributionGroup, bool>(
      (s_) => s_.notifyTesters,
      (s_, notifyTesters) => s_.copyWith(notifyTesters: notifyTesters));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistributionGroup _$DistributionGroupFromJson(Map<String, dynamic> json) {
  return DistributionGroup(
    id: json['id'] as String,
    mandatoryUpdate: json['mandatory_update'] as bool,
    notifyTesters: json['notify_testers'] as bool,
  );
}

Map<String, dynamic> _$DistributionGroupToJson(DistributionGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mandatory_update': instance.mandatoryUpdate,
      'notify_testers': instance.notifyTesters,
    };
