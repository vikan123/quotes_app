import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:quotes_app/Screen/save_quotes.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesPage extends StatefulWidget {
  final String categoryname;

  const QuotesPage({Key? key, required this.categoryname}) : super(key: key);

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  List<String> quotes = [];
  List<String> authors = [];
  bool isDataThere = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initPrefs();
    getQuotes();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  getQuotes() async {
    String url = "https://quotes.toscrape.com/tag/${widget.categoryname}/";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    dom.Document document = parser.parse(response.body);
    final quotesClass = document.getElementsByClassName("quote");
    quotes = quotesClass
        .map((element) => element.getElementsByClassName('text')[0].innerHtml)
        .toList();
    authors = quotesClass
        .map((element) => element.getElementsByClassName('author')[0].innerHtml)
        .toList();
    setState(() {
      isDataThere = true;
    });
  }

  Future<void> shareQuote(String quote, String author) async {
    await Share.share('$quote - $author');
  }

  Future<void> saveQuote(String quote, String author) async {
    List<String> savedQuotes = prefs.getStringList('savedQuotes') ?? [];
    savedQuotes.add('$quote - $author');
    await prefs.setStringList('savedQuotes', savedQuotes);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Quote saved'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.categoryname} quotes",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedQuotesPage(quotes: [],),
                ),
              );
            },
            icon: Icon(Icons.save_alt),
          )
        ],
      ),
      body: isDataThere == false
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 700,
              child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      elevation: 10,
                      color: Colors.primaries[
                      Random().nextInt(Colors.primaries.length)],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              quotes[index],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              authors[index],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  shareQuote(quotes[index], authors[index]);
                                },
                                icon: Icon(Icons.share),
                              ),
                              IconButton(
                                onPressed: () {
                                  saveQuote(quotes[index], authors[index]);
                                },
                                icon: Icon(Icons.save),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

