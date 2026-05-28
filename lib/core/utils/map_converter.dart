/// Deeply converts a Firebase map with Object? keys to a Map with String keys.
///
/// Firebase Realtime Database returns maps with Object? keys/values.
/// json_serializable requires `Map<String, dynamic>`.
Map<String, dynamic> convertFirebaseMap(Map<Object?, Object?> map) {
  return map.map((key, value) {
    final convertedValue = _convertValue(value);
    return MapEntry(key.toString(), convertedValue);
  });
}

dynamic _convertValue(dynamic value) {
  if (value is Map) {
    return convertFirebaseMap(value as Map<Object?, Object?>);
  }
  if (value is List) {
    return value.map(_convertValue).toList();
  }
  return value;
}
