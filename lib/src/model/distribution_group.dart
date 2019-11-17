import 'package:functional_data/functional_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'distribution_group.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@FunctionalData()
class DistributionGroup extends $DistributionGroup {
  const DistributionGroup({
    @required this.id,
    this.mandatoryUpdate = true,
    this.notifyTesters = true,
  }) : assert(id != null);

  factory DistributionGroup.fromJson(Map<String, dynamic> json) => _$DistributionGroupFromJson(json);

  Map<String, dynamic> toJson() => _$DistributionGroupToJson(this);

  final String id;
  final bool mandatoryUpdate;

  final bool notifyTesters;
}
