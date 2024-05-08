import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:siberian_coffee/src/features/menu/data/user_repository.dart';
import 'package:siberian_coffee/src/features/menu/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepository _userRepository;
  UserBloc({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UserEmptyState()) {
    on<UserLoadUserEvent>(_loadAddress);
  }

  void _loadAddress(UserLoadUserEvent event, Emitter emit) {
    emit(UserLoadingState());
    User? user = _userRepository.loadUser();
    user != null ? emit(UserLoadedState(user: user)) : emit(UserEmptyState());
  }
}
