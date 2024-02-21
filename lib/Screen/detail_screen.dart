import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:share_extend/share_extend.dart';

import '../helper/db_helper.dart';
import '../modal/api.dart';
import '../utils/image_util.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<Alignment> position;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    position = Tween<Alignment>(
      begin: const Alignment(-3, -2),
      end: const Alignment(-1.8, -1.1),
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
    ApiModal allQuotes = ModalRoute.of(context)!.settings.arguments as ApiModal;


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
        title: Text(
          "Quotes Details",
          style: GoogleFonts.federo(),
        ),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  allQuotes.category,
                  style: GoogleFonts.federo(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                // height: s.height * 0.8,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Hero(
                  tag: 'd',
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02),
                      Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "${bgImagePath}white quotation.png",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Container(
                        margin: const EdgeInsets.all(12),
                        child: Text(
                          allQuotes.text,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.viaodaLibre(
                            fontSize: 24,
                            wordSpacing: 2,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(12),
                        alignment: Alignment.centerRight,
                        child: Text(
                          "- ${allQuotes.author}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.viaodaLibre(
                            fontSize: 22,
                            wordSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              DBHelper.dbHelper.insertLikeQuotes(
                                quotes: allQuotes.text,
                                category: allQuotes.category,
                                author: allQuotes.author,
                              );
                              Get.snackbar(
                                "Tab To Go",
                                "Favorites Quotes Added To Page...",
                                onTap: (snack) {
                                  Get.toNamed("/FavoritesPage");
                                },
                                duration: const Duration(
                                  milliseconds: 700,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.favorite_outlined,
                                size: 28,
                                color: Colors.redAccent.shade400,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(28),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                ShareExtend.share(
                                  allQuotes.text,
                                  'text',
                                  extraText: allQuotes.author,
                                );
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    color: Colors.black,
                                    size: 28,
                                    Icons.share_outlined,
                                  ),
                                  Text(
                                    "Share",
                                    style: GoogleFonts.quattrocento(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
