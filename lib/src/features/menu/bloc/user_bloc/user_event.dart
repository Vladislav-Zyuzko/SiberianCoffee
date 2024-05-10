part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class UserLoadUserEvent extends UserEvent {}

final class UserSaveAddressEvent extends UserEvent {
  final Address userCoffeeShopAddress;

  UserSaveAddressEvent({required this.userCoffeeShopAddress});
}
