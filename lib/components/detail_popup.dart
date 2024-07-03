import 'package:flutter/material.dart';
import 'package:takehomechallenge/model/model_get_fav.dart';

class DetailPopup extends StatelessWidget {
  final Datum data;

  DetailPopup(this.data);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Detail ${data.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image: data.image,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error));
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Name: ${data.name}'),
          Text('Species: ${data.species}'),
          Text('Gender: ${data.gender}'),
          Text('Origin: ${data.origin}'),
          Text('Location: ${data.location}'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
