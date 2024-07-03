// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:takehomechallenge/const.dart';
import 'package:takehomechallenge/database/database_instance.dart';
import 'package:takehomechallenge/model/model_get_all_character.dart';
import 'package:takehomechallenge/screen/detail_page.dart';
import 'package:takehomechallenge/screen/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Result> _charatList = [];
  TextEditingController txtcari = TextEditingController();
  List<Result> _searchResult = [];
  bool isError = false;
  String errorMessage = 'error';

  @override
  void initState() {
    super.initState();

    getChara();
  }

  Future<void> getChara() async {
    try {
      setState(() {
        isLoading = true;
        isError = false;
      });
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final modelProduct = modelGetAllCharacterFromJson(res.body);
        setState(() {
          _charatList = modelProduct.results ?? [];
          _searchResult = modelProduct.results ?? [];
        });
      } else {
        setState(() {
          isError = true;
          errorMessage = 'Failed to load data';
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        errorMessage = e.toString();
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "The Rick and Morty",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (isError) {
      return Center(
        child: Text(errorMessage),
      );
    } else if (_searchResult.isEmpty) {
      return Center(
        child: Text('No results found'),
      );
    } else {
      return GridView.builder(
        itemCount: _searchResult.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.87,
        ),
        itemBuilder: (context, index) {
          Result data = _searchResult[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailPage(data)));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Container(
                child: Column(
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        data.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
