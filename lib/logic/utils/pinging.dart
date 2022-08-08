import 'dart:async';
import 'dart:io';

class Pinging {
  final Duration timeout;
  final int maxPings;
  int _pingStartCount = 0;
  int _doneCount = 0;
  // List<Function>

  int get available => maxPings - _pingStartCount + _doneCount;

  Pinging({
    this.timeout = const Duration(milliseconds: 999),
    this.maxPings = 20,
  });

  Future<bool> ping({
    required PingingAddress addr,
    Duration? timeout,
  }) {
    Completer<bool> c = Completer();

    Socket.connect(addr.ip, addr.port, timeout: timeout ?? this.timeout)
        .then((socket) {
      // debugPrint("Success");
      socket.destroy();
      c.complete(true);
    }).catchError((error) {
      // debugPrint("Exception on Socket $error");
      c.complete(false);
    });

    return c.future;
  }

  Future<List<PingingAddress>> bulkPing({
    required List<PingingAddress> addresses,
    Duration? timeout,
    void Function(int all, int done, int pinging, int success)? onProgress,
    List<PingingAddress>? successes,
  }) async {
    successes = successes ?? [];
    Completer<List<PingingAddress>> c = Completer();

    for (int i = _pingStartCount; i < addresses.length; i++) {
      if (available < 0) return await c.future;

      bool isLast = available == 0;

      var addr = addresses[i];

      _pingStartCount++;

      onProgress?.call(addresses.length, _doneCount,
          _pingStartCount - _doneCount, successes.length);

      ping(addr: addr, timeout: timeout).then((value) async {
        if (value) {
          successes!.add(addr);
        }

        _doneCount++;

        onProgress?.call(addresses.length, _doneCount,
            _pingStartCount - _doneCount, successes!.length);

        if (isLast) {
          var res = await bulkPing(
            addresses: addresses,
            timeout: timeout,
            onProgress: onProgress,
            successes: successes,
          );

          c.complete(res);
        }

        if (_doneCount >= addresses.length) c.complete(successes);
      }).catchError((_) async {
        _doneCount++;

        onProgress?.call(addresses.length, _doneCount,
            _pingStartCount - _doneCount, successes!.length);

        if (isLast) {
          var res = await bulkPing(
            addresses: addresses,
            timeout: timeout,
            onProgress: onProgress,
            successes: successes,
          );

          c.complete(res);
        }

        if (_doneCount >= addresses.length) c.complete(successes);
      });
    }

    return await c.future;
  }
}

class PingingAddress {
  final String ip;
  final int port;

  PingingAddress(this.ip, [this.port = 443]);
}
