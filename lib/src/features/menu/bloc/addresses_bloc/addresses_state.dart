part of 'addresses_bloc.dart';

@immutable
sealed class AddressesState {}

final class AddressesLoadingState extends AddressesState {}

final class AddressesErrorState extends AddressesState {}

final class AddressesLoadedState extends AddressesState {
  final List<Address> addresses;

  AddressesLoadedState({required this.addresses});
}
