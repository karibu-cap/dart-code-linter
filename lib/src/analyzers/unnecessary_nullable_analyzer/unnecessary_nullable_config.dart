import '../../config_builder/models/analysis_options.dart';

/// Represents raw unused code config which can be merged with other raw configs.
class UnnecessaryNullableConfig {
  final Iterable<String> excludePatterns;
  final Iterable<String> analyzerExcludePatterns;
  final bool isMonorepo;
  final bool shouldPrintConfig;

  const UnnecessaryNullableConfig({
    required this.excludePatterns,
    required this.analyzerExcludePatterns,
    required this.isMonorepo,
    required this.shouldPrintConfig,
  });

  /// Creates the config from analysis [options].
  factory UnnecessaryNullableConfig.fromAnalysisOptions(
    AnalysisOptions options,
  ) =>
      UnnecessaryNullableConfig(
        excludePatterns: const [],
        analyzerExcludePatterns:
            options.readIterableOfString(['analyzer', 'exclude']),
        isMonorepo: false,
        shouldPrintConfig: false,
      );

  /// Creates the config from cli args.
  factory UnnecessaryNullableConfig.fromArgs(
    Iterable<String> excludePatterns, {
    required bool isMonorepo,
    required bool shouldPrintConfig,
  }) =>
      UnnecessaryNullableConfig(
        shouldPrintConfig: shouldPrintConfig,
        excludePatterns: excludePatterns,
        analyzerExcludePatterns: const [],
        isMonorepo: isMonorepo,
      );

  /// Merges two configs into a single one.
  ///
  /// Config coming from [overrides] has a higher priority
  /// and overrides conflicting entries.
  UnnecessaryNullableConfig merge(UnnecessaryNullableConfig overrides) =>
      UnnecessaryNullableConfig(
        excludePatterns: {...excludePatterns, ...overrides.excludePatterns},
        analyzerExcludePatterns: {
          ...analyzerExcludePatterns,
          ...overrides.analyzerExcludePatterns,
        },
        isMonorepo: isMonorepo || overrides.isMonorepo,
        shouldPrintConfig: shouldPrintConfig || overrides.shouldPrintConfig,
      );
}
