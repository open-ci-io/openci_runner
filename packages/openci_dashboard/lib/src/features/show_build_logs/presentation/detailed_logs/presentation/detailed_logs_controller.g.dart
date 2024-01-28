// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_logs_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchLogsHash() => r'bb1601ecfa3028ebb8b1b673079f8a4f78b8a363';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchLogs].
@ProviderFor(fetchLogs)
const fetchLogsProvider = FetchLogsFamily();

/// See also [fetchLogs].
class FetchLogsFamily extends Family<AsyncValue<dynamic>> {
  /// See also [fetchLogs].
  const FetchLogsFamily();

  /// See also [fetchLogs].
  FetchLogsProvider call(
    String documentId,
  ) {
    return FetchLogsProvider(
      documentId,
    );
  }

  @override
  FetchLogsProvider getProviderOverride(
    covariant FetchLogsProvider provider,
  ) {
    return call(
      provider.documentId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchLogsProvider';
}

/// See also [fetchLogs].
class FetchLogsProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [fetchLogs].
  FetchLogsProvider(
    String documentId,
  ) : this._internal(
          (ref) => fetchLogs(
            ref as FetchLogsRef,
            documentId,
          ),
          from: fetchLogsProvider,
          name: r'fetchLogsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchLogsHash,
          dependencies: FetchLogsFamily._dependencies,
          allTransitiveDependencies: FetchLogsFamily._allTransitiveDependencies,
          documentId: documentId,
        );

  FetchLogsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.documentId,
  }) : super.internal();

  final String documentId;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(FetchLogsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchLogsProvider._internal(
        (ref) => create(ref as FetchLogsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        documentId: documentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _FetchLogsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchLogsProvider && other.documentId == documentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, documentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchLogsRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `documentId` of this provider.
  String get documentId;
}

class _FetchLogsProviderElement
    extends AutoDisposeFutureProviderElement<dynamic> with FetchLogsRef {
  _FetchLogsProviderElement(super.provider);

  @override
  String get documentId => (origin as FetchLogsProvider).documentId;
}

String _$detailedLogsControllerHash() =>
    r'321cbcb87cfef630b663cf12d0a581e7c12c778f';

/// See also [DetailedLogsController].
@ProviderFor(DetailedLogsController)
final detailedLogsControllerProvider =
    AutoDisposeNotifierProvider<DetailedLogsController, void>.internal(
  DetailedLogsController.new,
  name: r'detailedLogsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$detailedLogsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DetailedLogsController = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
