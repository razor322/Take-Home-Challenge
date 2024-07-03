// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:takehomechallenge/const.dart';
import 'package:takehomechallenge/model/model_get_all_character.dart';
import 'package:takehomechallenge/screen/detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;
  late List<Result> _charatList = [];
  TextEditingController txtcari = TextEditingController();
  late List<Result> _searchResult = [];
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

  void _filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResult = _charatList;
      });
    } else {
      List<Result> filteredProducts = _charatList
          .where((chara) =>
              chara.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        _searchResult = filteredProducts;
      });
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
              "Search Page",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: _filterSearch,
              controller: txtcari,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.orange.shade100,
                hintText: "Search",
                hintStyle: TextStyle(fontWeight: FontWeight.w500),
              ),
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
    } else if (txtcari.text.isEmpty) {
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
