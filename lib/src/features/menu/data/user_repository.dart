import 'package:siberian_coffee/src/features/menu/data/data_sources/savable/savable_user_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/user.dart';
import 'package:siberian_coffee/src/features/menu/utils/user_mapper.dart';

abstract interface class IUserRepository {
  User? loadUser();
  Future<void> saveUser(User user);
}

class UserRepository implements IUserRepository {
  final ISavableUserDataSource _preferencesUserDataSource;

  const UserRepository({
    required ISavableUserDataSource preferencesUserDataSource,
  }) : _preferencesUserDataSource = preferencesUserDataSource;

  @override
  User? loadUser() {
    try {
      return _preferencesUserDataSource.loadUser().toModel();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveUser(User user) async {
    await _preferencesUserDataSource.saveUser(user: user.toDto());
  }
}
