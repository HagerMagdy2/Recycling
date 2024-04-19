import 'package:bloc/bloc.dart';
import 'package:firstly/data/remotDs/papers-remot-ds.dart';
import 'package:firstly/presintations/bloc/papers_event.dart';
import 'package:firstly/presintations/bloc/papers_event.dart';
import 'package:firstly/presintations/bloc/papers_state.dart';

class PapersBloc extends Bloc<PapersEvent, PapersState> {
  final PapersRemoteDs remoteDs;

  PapersBloc(this.remoteDs) : super(PapersInitial()) {
    on<PapersEvent>((event, emit) async {
      try {
        if (event is AddPapers) {
          emit(PapersLoadingState());
          await remoteDs.addPapers(event.product);
          add(GetPapers());
        } else if (event is AddProductToCart) {
          emit(PapersLoadingState());
          await remoteDs.addToCart(event.product);
          add(GetPapers());
        } else if (event is GetPapers) {
          emit(PapersLoadingState());
          final products = await remoteDs.getPapers();
          emit(PapersLoaded(products: products));
        } else if (event is GetCartProduct) {
          emit(PapersLoadingState());
          final products = await remoteDs.getCartProduct();
          emit(PapersLoaded(products: products));
        } else if (event is RemovePapers) {
          emit(PapersLoadingState());
          await remoteDs.removePapers(event.id);
          add(GetPapers());
        } else if (event is RemoveProductFromCart) {
          emit(PapersLoadingState());
          await remoteDs.removeProductFromCart(event.id);
          add(GetCartProduct());
        } else if (event is UpdatePapers) {
          emit(PapersLoadingState());
          await remoteDs.updatePapers(event.product);
          add(GetPapers());
        }
      } catch (e) {
        emit(PapersErrorState(errorMessage: e.toString()));
      }
    });
  }
}
