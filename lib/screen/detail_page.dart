// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:takehomechallenge/components/info_row.dart';
import 'package:takehomechallenge/database/database_instance.dart';
import 'package:takehomechallenge/model/model_get_all_character.dart';
import 'package:takehomechallenge/model/model_get_fav.dart';

class DetailPage extends StatefulWidget {
  final Result data;
  const DetailPage(this.data, {super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  DatabaseInstance databaseInstance = DatabaseInstance();
  bool isFavorite = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseInstance.database();
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final data = widget.data;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Center(
                  child: Text(
                    "Character ${widget.data.name} ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/placeholder.png',
                      image: widget.data.image,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Center(child: Icon(Icons.error));
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                    minHeight: 430,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await databaseInstance.insert({
                                      'name': data.name,
                                      'species': data.species,
                                      'gender': data.gender,
                                      'origin': data.origin.name,
                                      'location': data.location.name,
                                      'image': data.image,
                                    });
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.red,
                                    size: 30,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InfoRow(label: "Species", value: data.species),
                        InfoRow(label: "Gender", value: data.gender),
                        InfoRow(label: "Location", value: data.location.name),
                        InfoRow(label: "Origin", value: data.origin.name),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
