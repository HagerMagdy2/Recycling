import 'package:bloc/bloc.dart';
import 'package:firstly/data/remotDs/oil_remot_ds.dart';
import 'package:firstly/presintations/bloc/oils_event.dart';
import 'package:firstly/presintations/bloc/oils_event.dart';
import 'package:firstly/presintations/bloc/oils_state.dart';

class OilsBloc extends Bloc<OilsEvent, OilsState> {
  final OilRemoteDs remoteDs;

  OilsBloc(this.remoteDs) : super(OilsInitial()) {
    on<OilsEvent>((event, emit) async {
      try {
        if (event is AddOils) {
          emit(OilsLoadingState());
          await remoteDs.addOil(event.product);
          add(GetOils());
        } else if (event is AddProductToCart) {
          emit(OilsLoadingState());
          await remoteDs.addToCart(event.product);
          add(GetOils());
        } else if (event is GetOils) {
          emit(OilsLoadingState());
          final products = await remoteDs.getOil();
          emit(OilsLoaded(products: products));
        } else if (event is GetCartProduct) {
          emit(OilsLoadingState());
          final products = await remoteDs.getCartProduct();
          emit(OilsLoaded(products: products));
        } else if (event is RemoveOils) {
          emit(OilsLoadingState());
          await remoteDs.removeOil(event.id);
          add(GetOils());
        } else if (event is RemoveProductFromCart) {
          emit(OilsLoadingState());
          await remoteDs.removeProductFromCart(event.id);
          add(GetCartProduct());
        } else if (event is UpdateOils) {
          emit(OilsLoadingState());
          await remoteDs.updateOil(event.product);
          add(GetOils());
        }
      } catch (e) {
        emit(OilsErrorState(errorMessage: e.toString()));
      }
    });
  }
}
