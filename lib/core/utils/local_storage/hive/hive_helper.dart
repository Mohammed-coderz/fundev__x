import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'const/hive_boxes.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(HiveBoxes.authBox);
    await Hive.openBox(HiveBoxes.settingsBox);
    await Hive.openBox(HiveBoxes.cartBox);
    await Hive.openBox(HiveBoxes.cacheBox);
    await Hive.openBox(HiveBoxes.userBox);
  }

  static Box _getBox(String boxName) {
    return Hive.box(boxName);
  }

  static Future<void> saveData({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    await _getBox(boxName).put(key, value);
  }

  static T? getData<T>({
    required String boxName,
    required String key,
    T? defaultValue,
  }) {
    return _getBox(boxName).get(
      key,
      defaultValue: defaultValue,
    ) as T?;
  }

  static Future<void> removeData({
    required String boxName,
    required String key,
  }) async {
    await _getBox(boxName).delete(key);
  }

  static Future<void> clearBox({
    required String boxName,
  }) async {
    await _getBox(boxName).clear();
  }
  /// check if the key available or not
  static bool containsKey({
    required String boxName,
    required String key,
  }) {
    return _getBox(boxName).containsKey(key);
  }
  /// get all keys from the box
  static List getKeys({
    required String boxName,
  }) {
    return _getBox(boxName).keys.toList();
  }
  /// get item value by key and box name
  static dynamic getValueByKey({
    required String boxName,
    required dynamic key,
  }) {
    return _getBox(boxName).get(key);
  }
  /// listener
  static ValueListenable<Box> listenToBox({
    required String boxName,
  }) {
    return _getBox(boxName).listenable();
  }
}