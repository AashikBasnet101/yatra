import 'dart:io';
import 'package:newprojectfirebase/features/cloudinary/model/add_places.dart';

abstract class AddPlacesEvent {}

class AddPlaceEvent extends AddPlacesEvent {
  final AddPlace place;
  final File imageFile;

  AddPlaceEvent({
    required this.place,
    required this.imageFile,
  });
}




//get places event 
abstract class GetPlacesEvent {}

class FetchPlacesEvent extends GetPlacesEvent {}

class RemovePlaceFromUIEvent extends GetPlacesEvent {
  final String placeId;
  RemovePlaceFromUIEvent(this.placeId);
}



//delete place event
abstract class DeletePlaceEvent {}

class DeletePlaceByIdEvent extends DeletePlaceEvent {
  final String placeId;
  DeletePlaceByIdEvent(this.placeId);
}


