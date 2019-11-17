import 'package:app_center_uploader/src/model/api_config.dart';
import 'package:app_center_uploader/src/model/distribution_group.dart';
import 'package:app_center_uploader/src/model/release_info.dart';
import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';

part 'run_data.g.dart';

@FunctionalData()
class RunData extends $RunData {
  const RunData({
    @required this.config,
    @required this.release,
    @required this.group,
    @required this.artefactLocation,
  })  : assert(config != null),
        assert(release != null),
        assert(group != null),
        assert(artefactLocation != null);

  factory RunData.fromConfig(
      {@required String apiToken,
      @required String buildVersion,
      @required String artefactlocation,
      @required Map<String, String> yaml}) {
    final releaseInfo = ReleaseInfo(buildVersion: buildVersion);
    final appRelease = AppRelease(appName: yaml['appName'], releaseInfo: releaseInfo);
    final config = ApiConfig(owner: yaml['owner'], apiToken: apiToken);
    final group = DistributionGroup(id: yaml['distributionGroup']);

    return RunData(config: config, release: appRelease, group: group, artefactLocation: artefactlocation);
  }

  final ApiConfig config;
  final AppRelease release;
  final DistributionGroup group;

  final String artefactLocation;
}
