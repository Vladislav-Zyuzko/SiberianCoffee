import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:siberian_coffee/src/features/menu/bloc/addresses_bloc/addresses_bloc.dart';
import 'package:siberian_coffee/src/features/menu/data/user_repository.dart';
import 'package:siberian_coffee/src/features/menu/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepository _userRepository;
  final AddressesBloc _addressesBloc;
  late final StreamSubscription _addressesBlocSubscription;
  UserBloc({
    required IUserRepository userRepository,
    required AddressesBloc addressesBloc,
  }): _userRepository = userRepository, _addressesBloc = addressesBloc,
  super(UserEmptyState()) {
    on<UserLoadUserEvent>(_loadUser);
    _addressesBlocSubscription = _addressesBloc.stream.listen((state) {
      if (state is AddressesLoadedState && this.state is UserEmptyState) {
        add(UserLoadUserEvent());
      }
    });
  }

  @override
  Future<void> close() async {
    _addressesBlocSubscription.cancel();
    return super.close();
  }

  void _loadUser(UserLoadUserEvent event, Emitter emit) {
    emit(UserLoadingState());
    User user = _userRepository.loadUser();
    emit(UserLoadedState(user: user));
  }
}
