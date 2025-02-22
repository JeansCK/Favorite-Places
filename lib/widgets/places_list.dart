import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_detail.dart';
import 'package:favorite_places/providers/user_places.dart';

class PlacesList extends ConsumerStatefulWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  ConsumerState<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends ConsumerState<PlacesList> {
  void _deletePlace(id) {
    ref.read(userPlacesProvider.notifier).deletePlace(id);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      );
    }

    return ListView.builder(
      itemCount: widget.places.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(widget.places[index].id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Theme.of(context).colorScheme.error,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (direction) {
          _deletePlace(widget.places[index].id);
        },
        child: ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: FileImage(widget.places[index].image),
          ),
          title: Text(
            widget.places[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          subtitle: Text(
            widget.places[index].location.address,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) =>
                    PlaceDetailScreen(place: widget.places[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
