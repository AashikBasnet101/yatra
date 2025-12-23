import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprojectfirebase/features/cloudinary/bloc/add_places_event.dart';
import 'package:newprojectfirebase/features/cloudinary/bloc/add_places_state.dart';
import 'package:newprojectfirebase/features/cloudinary/model/add_places.dart';
import 'package:newprojectfirebase/utils/cloudinary.dart';

class AddPlacesBloc extends Bloc<AddPlacesEvent, AddPlacesState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AddPlacesBloc() : super(AddPlacesInitialState()) {
    on<AddPlaceEvent>((event, emit) async {
      emit(AddPlacesLoadingState());

      try {
        final imageData =
            await CloudinaryService().uploadImage(event.imageFile);

        await firestore.collection('places').add({
          ...event.place.toJson(),
          'url': imageData['secure_url'],
          'public_id': imageData['public_id'],
          'createdAt': FieldValue.serverTimestamp(),
        });

        emit(AddPlacesLoadedState());
      } catch (e) {
        emit(AddPlacesErrorState(e.toString()));
      }
    });
  }
}



//get places bloc
class GetPlacesBloc extends Bloc<GetPlacesEvent, GetPlacesState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetPlacesBloc() : super(GetPlacesInitialState()) {
    // FETCH PLACES
    on<FetchPlacesEvent>((event, emit) async {
      emit(GetPlacesLoadingState());

      try {
        final snapshot = await firestore
            .collection('places')
            .orderBy('createdAt', descending: true)
            .get();

        final places = snapshot.docs.map((doc) {
          final data = doc.data();
          return AddPlace.fromJson({
            "id": doc.id,
            ...data,
          });
        }).toList();

        emit(GetPlacesLoadedState(places));
      } catch (e) {
        emit(GetPlacesErrorState(e.toString()));
      }
    });



    // REMOVE PLACE FROM UI (🔥 THIS WAS MISSING)
    on<RemovePlaceFromUIEvent>((event, emit) {
      if (state is GetPlacesLoadedState) {
        final currentState = state as GetPlacesLoadedState;

        final updatedPlaces = currentState.places
            .where((place) => place.id != event.placeId)
            .toList();

        emit(GetPlacesLoadedState(updatedPlaces));
      }
    });
  }
}



class DeletePlaceBloc extends Bloc<DeletePlaceEvent, DeletePlaceState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DeletePlaceBloc() : super(DeletePlaceInitialState()) {
    on<DeletePlaceByIdEvent>((event, emit) async {
      emit(DeletePlaceLoadingState());

      try {
        await firestore
            .collection('places')
            .doc(event.placeId)
            .delete();

        emit(DeletePlaceSuccessState(event.placeId));
      } catch (e) {
        emit(DeletePlaceErrorState(e.toString()));
      }
    });
  }
}
