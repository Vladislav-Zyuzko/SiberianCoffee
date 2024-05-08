import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:siberian_coffee/src/features/menu/data/address_repository.dart';
import 'package:siberian_coffee/src/features/menu/models/address.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  final IAddressRepository _addressRepository;
  AddressesBloc({
    required IAddressRepository addressRepository,
  })  : _addressRepository = addressRepository,
        super(AddressesLoadingState()) {
    on<AddressesLoadAddressesEvent>(_loadAddresses);
  }

  void _loadAddresses(AddressesLoadAddressesEvent event, Emitter emit) async {
    emit(AddressesLoadingState());
    List<Address> addresses = await _addressRepository.loadAddresses();
    emit(AddressesLoadedState(addresses: addresses));
  }
}
