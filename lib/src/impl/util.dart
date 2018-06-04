import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

abstract class Serializable {
  static Map<String, Object> _uninitialized = {};
  String cachedToString;
  Map<String, Object> cachedMap = _uninitialized;

  @override
  bool operator ==(dynamic other) {
    if (this.runtimeType != other.runtimeType) {
      return false;
    }
    return toString() == other.toString();
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    if (cachedToString == null) {
      cachedToString = JSON.encode(toMap());
    }
    return cachedToString;
  }

  Map<String, Object> createMap();

  Map<String, Object> toMap() {
    if (identical(cachedMap, _uninitialized)) {
      cachedMap = createMap();
    }
    return cachedMap;
  }

  static Map<String, Object> toMapOrNull(Object o) =>
      (o as Serializable)?.toMap();
}

Map<String, Object> noNull(Map<String, Object> map) {
  Map<String, Object> result = {};
  map.forEach((k, v) {
    if (v != null) {
      result[k] = v;
    }
  });
  return result;
}

List<T> copyListAllowed<T>(Iterable<T> original, Iterable<T> allowed) {
  if (original == null) {
    return null;
  }
  List<T> resultList = [];
  for (T elem in original) {
    if (allowed.contains(elem)) {
      resultList.add(elem);
    }
  }
  return new List.unmodifiable(resultList);
}

List<T> copyList<T>(Iterable<T> original) {
  if (original == null) {
    return null;
  }
  return new List.unmodifiable(original);
}

Iterable<O> mapOrNull<I, O>(Iterable<I> original, O mapFunction(I element)) {
  if (original == null) {
    return null;
  }
  return original.map(mapFunction);
}

List<Object> ls(List<Serializable> list) =>
    copyList(mapOrNull(list, (e) => e.toMap()));

List<List<O>> ii2ll<I, O>(Iterable<Iterable<I>> source, O convert(I from)) =>
    copyList(
        mapOrNull(source, (i) => copyList(mapOrNull(i, (el) => convert(el)))));

List<List<Object>> ll2m<I>(
        List<List<I>> source, Map<String, Object> convert(I from)) =>
    mapOrNull(source, (lst) => lst.map((e) => convert(e)));

Future<Map<String, Object>> postToViber(
  String token,
  String method, [
  Map<String, Object> data = const {},
]) async {
  const String viberUrl = 'https://chatapi.viber.com/pa/';
  var body = data == null || data.isEmpty ? "" : JSON.encode(data);
  final Response response = await post(viberUrl + method,
      body: body, headers: {'X-Viber-Auth-Token': token});
  return JSON.decode(response.body);
}

String json2string(Object map) {
  return JSON.encode(map);
}
