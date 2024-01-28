// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_build_logs_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchBuildListHash() => r'30279934e40cca0bab08ef52172b8c79a3faf4af';

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

/// See also [fetchBuildList].
@ProviderFor(fetchBuildList)
const fetchBuildListProvider = FetchBuildListFamily();

/// See also [fetchBuildList].
class FetchBuildListFamily extends Family<AsyncValue<dynamic>> {
  /// See also [fetchBuildList].
  const FetchBuildListFamily();

  /// See also [fetchBuildList].
  FetchBuildListProvider call(
    String userId,
  ) {
    return FetchBuildListProvider(
      userId,
    );
  }

  @override
  FetchBuildListProvider getProviderOverride(
    covariant FetchBuildListProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'fetchBuildListProvider';
}

/// See also [fetchBuildList].
class FetchBuildListProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [fetchBuildList].
  FetchBuildListProvider(
    String userId,
  ) : this._internal(
          (ref) => fetchBuildList(
            ref as FetchBuildListRef,
            userId,
          ),
          from: fetchBuildListProvider,
          name: r'fetchBuildListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchBuildListHash,
          dependencies: FetchBuildListFamily._dependencies,
          allTransitiveDependencies:
              FetchBuildListFamily._allTransitiveDependencies,
          userId: userId,
        );

  FetchBuildListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(FetchBuildListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchBuildListProvider._internal(
        (ref) => create(ref as FetchBuildListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _FetchBuildListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchBuildListProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchBuildListRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FetchBuildListProviderElement
    extends AutoDisposeFutureProviderElement<dynamic> with FetchBuildListRef {
  _FetchBuildListProviderElement(super.provider);

  @override
  String get userId => (origin as FetchBuildListProvider).userId;
}

String _$showBuildLogsControllerHash() =>
    r'bbe09104fd40e2d67348ac6c7d1af9e14743ba6c';

/// See also [ShowBuildLogsController].
@ProviderFor(ShowBuildLogsController)
final showBuildLogsControllerProvider = AutoDisposeAsyncNotifierProvider<
    ShowBuildLogsController, ShowBuildLogs>.internal(
  ShowBuildLogsController.new,
  name: r'showBuildLogsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$showBuildLogsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShowBuildLogsController = AutoDisposeAsyncNotifier<ShowBuildLogs>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
