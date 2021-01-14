import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/toilet_places_provider.dart';
import './add_place_screen.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  // static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toilet Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ToiletPlace>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Consumer<ToiletPlace>(
                  child: Center(
                      child:
                          const Text('Get no place yet, start adding some!')),
                  builder: (ctx, toiletPlaces, ch) =>
                      toiletPlaces.items.length <= 0
                          ? ch
                          : ListView.builder(
                              itemBuilder: (ctx, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    toiletPlaces.items[index].image,
                                  ),
                                ),
                                title: Text(toiletPlaces.items[index].title),
                                subtitle: Text(
                                    toiletPlaces.items[index].location.address),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: toiletPlaces.items[index].id,
                                  );
                                },
                              ),
                              itemCount: toiletPlaces.items.length,
                            ),
                ),
              ),
      ),
    );
  }
}
