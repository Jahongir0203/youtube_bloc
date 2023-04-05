import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:youtube_bloc/constantas/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
   Connectivity connectivity;
   StreamSubscription ?  connectivityStreamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetLoading()){
    connectivityStreamSubscription=connectivity.onConnectivityChanged.listen((connectivityResult) {
      if(connectivityResult==ConnectivityResult.wifi){
        emitInternetConnected(ConnectionType.Wifi);
      }else if(connectivityResult==ConnectivityResult.mobile){
        emitInternetConnected(ConnectionType.Mobile);
      }else if(connectivityResult==ConnectivityResult.none){
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected (ConnectionType _connectionType)=>
    emit (InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected()=>emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
