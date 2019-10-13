import 'package:meta/meta.dart';

class ApiConfig {
  const ApiConfig({
    @required this.owner,
    @required this.apiToken,
  })  : assert(owner != null),
        assert(apiToken != null);

  final String owner;
  final String apiToken;
}
