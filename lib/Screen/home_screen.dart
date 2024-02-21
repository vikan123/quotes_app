import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/get/save_controller.dart';

import '../get/api_controller.dart';
import '../get/quotes_controller.dart';
import '../helper/api_helper.dart';
import '../helper/db_helper.dart';
import '../modal/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ApiController apiController = Get.put(ApiController());

  final SaveController _favoritesController = Get.put(SaveController());

  final QuotesController _quotesController = Get.put(QuotesController());

  late AnimationController controller;
  late Animation<Alignment> position;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    position = Tween<Alignment>(
      begin: const Alignment(-3, -2),
      end: const Alignment(0, 0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.1, 0.4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'E',
          transitionOnUserGestures: true,
          child: Text(
            "MOTIVATION",
            style: GoogleFonts.federo(),
          ),
        ),
        actions: [
          Hero(
            tag: 'f',
            child: IconButton(
              onPressed: () {
                _favoritesController.getAllFavoritesQuotes;
                Get.toNamed('/FavoritesPage');
              },
              icon: const Icon(
                Icons.save_alt_outlined,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Transform.translate(
              offset: const Offset(0, 18),
              child: AlignTransition(
                alignment: position,
                child: Container(
                  height: size.height * 0.88,
                  margin: const EdgeInsets.all(6),
                  child: FutureBuilder(
                      future: ApiHelper.apiHelper.getApi(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Obx(() => Text("Error: ${snapshot.error}"));
                        }
                        //log("{] ${snapshot.data} [}");
                        else if (snapshot.hasData) {
                          List<ApiModal>? allQuotes = snapshot.data as List<ApiModal>?;

                          if (allQuotes != null) {
                            return
                                   ListView.builder(
                                itemCount: allQuotes.length,
                                itemBuilder: (context, index) {
                                  ApiModal allQuote = allQuotes[index];
                                  log("[+ ${allQuote.author} -]");
                                  return GestureDetector(
                                    onTap: () {
                                      DBHelper.dbHelper.insertQuotes(
                                        quotes: allQuote.text ?? '',
                                        category: allQuote.category ?? '',
                                        author: allQuote.author ?? '',
                                      );
                                      _quotesController.getAllHistoryQuotes;

                                      Get.toNamed(
                                        "/DetailPage",
                                        arguments: allQuote,
                                      );
                                    },
                                    child: Hero(
                                      tag: 'd',
                                      child: Container(
                                        padding: const EdgeInsets.all(18),
                                        margin: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.primaries[index % 18].shade50,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                allQuote.category ?? 'Unknown',
                                                style: GoogleFonts.quattrocento(
                                                  fontSize: 18,
                                                  letterSpacing: 2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              allQuote.text?.toString() ?? '', // Use null-aware operators
                                              style: GoogleFonts.quattrocento(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "- ${allQuote.author}".toString(),
                                                style: GoogleFonts.quattrocento(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
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
                        return Center(
                          child: Text(
                            "Finding Quotes For You !!!",
                            style: GoogleFonts.federo(
                              fontSize: 20,
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
