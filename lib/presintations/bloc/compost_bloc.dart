import 'package:bloc/bloc.dart';
import 'package:firstly/data/remotDs/compost-remot-ds.dart';
import 'package:firstly/presintations/bloc/compost_event.dart';
import 'package:firstly/presintations/bloc/compost_state.dart';

class CompostBloc extends Bloc<CompostEvent, CompostState> {
  final CompostRemoteDs remoteDs;

  CompostBloc(this.remoteDs) : super(CompostInitial()) {
    on<CompostEvent>((event, emit) async {
      try {
        if (event is AddCompost) {
          emit(CompostLoadingState());
          await remoteDs.addCompost(event.product);
          add(GetCompost());
        } else if (event is AddProductToCart) {
          emit(CompostLoadingState());
          await remoteDs.addToCart(event.product);
          add(GetCompost());
        } else if (event is GetCompost) {
          emit(CompostLoadingState());
          final products = await remoteDs.getCompost();
          emit(CompostLoaded(products: products));
        } else if (event is GetCartProduct) {
          emit(CompostLoadingState());
          final products = await remoteDs.getCartProduct();
          emit(CompostLoaded(products: products));
        } else if (event is RemoveCompost) {
          emit(CompostLoadingState());
          await remoteDs.removeCompost(event.id);
          add(GetCompost());
        } else if (event is RemoveProductFromCart) {
          emit(CompostLoadingState());
          await remoteDs.removeProductFromCart(event.id);
          add(GetCartProduct());
        } else if (event is UpdateCompost) {
          emit(CompostLoadingState());
          await remoteDs.updateCompost(event.product);
          add(GetCompost());
        }
      } catch (e) {
        emit(CompostErrorState(errorMessage: e.toString()));
      }
    });
  }
}
