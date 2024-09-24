import 'dart:convert';

import 'package:lichess_mobile/src/constants.dart';
import 'package:lichess_mobile/src/db/secure_storage.dart';
import 'package:lichess_mobile/src/model/auth/auth_session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_storage.g.dart';

const _kSessionStorageKey = '$kLichessHost.userSession';

@Riverpod(keepAlive: true)
SessionStorage sessionStorage(SessionStorageRef ref) {
  return const SessionStorage();
}

class SessionStorage {
  const SessionStorage();

  Future<AuthSessionState?> read() async {
    final string = await SecureStorage.instance.read(key: _kSessionStorageKey);
    if (string != null) {
      return AuthSessionState.fromJson(
        jsonDecode(string) as Map<String, dynamic>,
      );
    }
    return null;
  }

  Future<void> write(AuthSessionState session) async {
    await SecureStorage.instance.write(
      key: _kSessionStorageKey,
      value: jsonEncode(session.toJson()),
    );
  }

  Future<void> delete() async {
    await SecureStorage.instance.delete(key: _kSessionStorageKey);
  }
}
