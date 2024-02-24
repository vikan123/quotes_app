import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedQuotesPage extends StatefulWidget {
  final List quotes;

  const SavedQuotesPage({super.key, required this.quotes});

  @override
  State<SavedQuotesPage> createState() => _SavedQuotesPageState();
}

class _SavedQuotesPageState extends State<SavedQuotesPage> {
  late List<String> quotes;

  @override
  void initState() {
    super.initState();
    quotes = List<String>.from(widget.quotes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Quotes"),
      ),
      body: FutureBuilder<List<String>>(
        future: getSavedQuotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No saved quotes'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color:Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(snapshot.data![index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                              IconButton(onPressed: (){
                                _deleteQuote(index);
                              }, icon: Icon(Icons.delete))
                            ],
                          )
                        ),
                      )
                    ],
                  )
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> getSavedQuotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('savedQuotes') ?? [];
  }
  Future<void> _deleteQuote(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.quotes.removeAt(i);
    });
    await prefs.setStringList('savedQuotes', quotes);
  }
}
