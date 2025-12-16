import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprojectfirebase/features/auth/bloc/auth_event.dart';
import 'package:newprojectfirebase/features/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthBloc() : super( AuthInitialState()) {
    on <SignupEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await firestore.collection('users').add({
          'name': event.user?.name,
          'address': event.user?.address,
          'phoneNumber': event.user?.phone,
          'emailAddress': event.user?.email,
          'password': event.user?.password,
          'identity':{
            'idType': event.user?.identity?.type,
            'url': event.user?.identity?.url,
          },
          'profileUrl': event.user?.profileUrl,
        });
        
        emit(AuthLoadedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });
    
  }
}