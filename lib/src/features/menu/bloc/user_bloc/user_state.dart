part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserEmptyState extends UserState {}

final class UserLoadingState extends UserState {}

final class UserLoadedState extends UserState {
  final User user;

  UserLoadedState({required this.user});
}
