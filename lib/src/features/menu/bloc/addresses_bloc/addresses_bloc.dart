import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:siberian_coffee/src/features/menu/data/address_repository.dart';
import 'package:siberian_coffee/src/features/menu/data/user_repository.dart';
import 'package:siberian_coffee/src/features/menu/models/address.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  final IAddressRepository _addressRepository;
  final IUserRepository _userRepository;
  AddressesBloc({
    required IAddressRepository addressRepository,
    required IUserRepository userRepository,
  })  : _addressRepository = addressRepository,
        _userRepository = userRepository,
        super(AddressesLoadingState()) {
    on<AddressesLoadAddressesEvent>(_loadAddresses);
  }

  void _loadAddresses(AddressesLoadAddressesEvent event, Emitter emit) async {
    emit(AddressesLoadingState());
    List<Address> addresses = await _addressRepository.loadAddresses();
    Address? userCoffeeShopAddress =
        _userRepository.loadUserCoffeeShopAddress();
    if (addresses.isNotEmpty) {
      if (userCoffeeShopAddress == null ||
          !containAddress(addresses, userCoffeeShopAddress)) {
        _userRepository.saveUserCoffeeShopAddress(address: addresses.first);
      }
    }
    emit(AddressesLoadedState(addresses: addresses));
  }

  bool containAddress(List<Address> addresses, Address userAddress) {
    for (Address address in addresses) {
      if (address.lat == userAddress.lat && address.lng == userAddress.lng) {
        return true;
      }
    }
    return false;
  }
}
