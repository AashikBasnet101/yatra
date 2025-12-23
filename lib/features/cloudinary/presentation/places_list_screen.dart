import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprojectfirebase/add_places.dart';
import 'package:newprojectfirebase/features/cloudinary/bloc/add_places_bloc.dart';
import 'package:newprojectfirebase/features/cloudinary/bloc/add_places_event.dart';
import 'package:newprojectfirebase/features/cloudinary/bloc/add_places_state.dart';

import '../model/add_places.dart';


class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetPlacesBloc()..add(FetchPlacesEvent())),
        BlocProvider(create: (_) => DeletePlaceBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Places"), centerTitle: true),
        body: BlocListener<DeletePlaceBloc, DeletePlaceState>(
          listener: (context, state) {
            if (state is DeletePlaceSuccessState) {
              context.read<GetPlacesBloc>().add(
                RemovePlaceFromUIEvent(state.placeId),
              );

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Place deleted")));
            }
          },
          child: BlocBuilder<GetPlacesBloc, GetPlacesState>(
            builder: (context, state) {
              if (state is GetPlacesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GetPlacesLoadedState) {
                if (state.places.isEmpty) {
                  return const Center(child: Text("No places found"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.places.length,
                  itemBuilder: (context, index) {
                    final AddPlace place = state.places[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (place.url != null)
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                place.url!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ListTile(
                            title: Text(place.destination),
                            subtitle: Text(place.aboutDestination),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    // edit logic
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text("Delete Place"),
                                        content: const Text(
                                            "Are you sure you want to delete?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              context
                                                  .read<DeletePlaceBloc>()
                                                  .add(DeletePlaceByIdEvent(place.id!));
                                            },
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
        //  FloatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddPlacesScreen()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
