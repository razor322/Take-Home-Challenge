// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:takehomechallenge/components/detail_popup.dart';
import 'package:takehomechallenge/database/database_instance.dart';
import 'package:takehomechallenge/model/model_get_fav.dart';
import 'package:takehomechallenge/screen/detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  Future<List<Datum>>? _futureData;

  @override
  void initState() {
    super.initState();
    // databaseInstance.database();
    _initDatabaseAndFetchData();
  }

  Future<void> _initDatabaseAndFetchData() async {
    await databaseInstance.database();
    setState(() {
      _futureData = databaseInstance.all();
    });
  }

  Future delete(int id) async {
    await databaseInstance.delete(id);
    setState(() {
      _futureData = databaseInstance.all();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Page')),
      body: FutureBuilder<List<Datum>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Datum data = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DetailPopup(data);
                      },
                    );
                  },
                  leading: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: data.image,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Center(child: Icon(Icons.error));
                    },
                  ),
                  title: Text(data.name),
                  subtitle: Text('${data.species}, ${data.gender}'),
                  trailing: IconButton(
                      onPressed: () => delete(data.id),
                      icon: Icon(Icons.delete)),
                );
              },
            );
          }
        },
      ),
    );
  }
}
