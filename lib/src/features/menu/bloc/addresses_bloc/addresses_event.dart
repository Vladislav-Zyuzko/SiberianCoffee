part of 'addresses_bloc.dart';

@immutable
sealed class AddressesEvent {}

class AddressesLoadAddressesEvent extends AddressesEvent {}
