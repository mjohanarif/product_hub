import 'package:hive/hive.dart';

import 'shared.dart';

class CacheHandler {
  final HiveInterface cache;

  const CacheHandler({
    required this.cache,
  });

  Future<void> deleteCache({
    required String boxKey,
  }) async {
    try {
      final box = await _getBox(boxKey);
      await box.delete(boxKey);

      return;
    } catch (e) {
      throw CacheException(message: "Can't delete data");
    }
  }

  Future<T?> setCache<T>({
    required String boxKey,
    required T value,
  }) async {
    try {
      final box = await _getBox(boxKey);
      await box.put(boxKey, value);
      final Object? data = box.get(boxKey);

      if (data is T) {
        return data;
      }

      return null;
    } catch (e) {
      throw CacheException(message: "Can't save data");
    }
  }

  Future<T?> getCache<T>({
    required String boxKey,
  }) async {
    try {
      final box = await _getBox(boxKey);
      final Object? data = box.get(boxKey);
      if (data is! T) {
        throw CacheException(message: "Data type is not the same");
      }

      return data;
    } catch (e) {
      throw CacheException(message: "Can't get data");
    }
  }

  // get box from hive
  Future<Box> _getBox(String boxKey) async {
    if (cache.isBoxOpen(boxKey)) {
      return cache.box<dynamic>(boxKey);
    }

    return cache.openBox<dynamic>(boxKey);
  }
}
