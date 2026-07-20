import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapMemoryCacheProvider = Provider<MemCacheStore>((ref) {
  return MemCacheStore(maxSize: 10485760);
});

final mapProvider = Provider<TileLayer>((ref) {
  final memoryStore = ref.watch(mapMemoryCacheProvider);

  return TileLayer(
    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
    userAgentPackageName: 'com.fit_vault.fit_vault_flutter',
    tileProvider: CachedTileProvider(
      store: memoryStore,
      cachePolicy: CachePolicy.forceCache,
      maxStale: const Duration(hours: 2),
    ),
  );
});
