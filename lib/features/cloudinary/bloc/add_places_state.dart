import 'package:newprojectfirebase/features/cloudinary/model/add_places.dart';

abstract class AddPlacesState {}

class AddPlacesInitialState extends AddPlacesState {}

class AddPlacesLoadingState extends AddPlacesState {}

class AddPlacesLoadedState extends AddPlacesState {}

class AddPlacesErrorState extends AddPlacesState {
  final String message;
  AddPlacesErrorState(this.message);
}


//get places state


abstract class GetPlacesState {}

class GetPlacesInitialState extends GetPlacesState {}

class GetPlacesLoadingState extends GetPlacesState {}

class GetPlacesLoadedState extends GetPlacesState {
  final List<AddPlace> places;
  GetPlacesLoadedState(this.places);
}

class GetPlacesErrorState extends GetPlacesState {
  final String message;
  GetPlacesErrorState(this.message);
}



//delete places event
abstract class DeletePlaceState {}

class DeletePlaceInitialState extends DeletePlaceState {}

class DeletePlaceLoadingState extends DeletePlaceState {}

class DeletePlaceSuccessState extends DeletePlaceState {
  final String placeId;
  DeletePlaceSuccessState(this.placeId);
}

class DeletePlaceErrorState extends DeletePlaceState {
  final String error;
  DeletePlaceErrorState(this.error);
}
