import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:jsonplaceholder_app/data/api/api_client.dart';

class Storage {
  factory Storage() => instance;

  static Storage instance = Storage._constructor();

  Storage._constructor() {
    apiBox = Hive.lazyBox("appBox");
  }

  late LazyBox apiBox;

  Future<dynamic> getCachedOrLoad(ApiLoader apiLoader) async {
    final c = Completer<dynamic>();

    apiLoader.loader().then((res) {
      final data = res.data;

      if (!c.isCompleted) {
        c.complete(data);
      }

      if (data is Iterable) {
        apiBox.put(apiLoader.path, jsonEncode(data.toList()));
      } else {
        apiBox.put(apiLoader.path, jsonEncode(data));
      }
    });

    if (apiBox.containsKey(apiLoader.path)) {
      String raw = await apiBox.get(apiLoader.path);

      if (!c.isCompleted) {
        c.complete(jsonDecode(raw));
      }
    }

    return c.future;
  }
}
