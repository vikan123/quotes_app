import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quotes_app/get/save_controller.dart';

import '../modal/saves_screen.dart';

class SaveScreen extends StatelessWidget {
   SaveScreen({super.key});

  final SaveController _controller = Get.put(SaveController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
        title: Hero(
          tag: 'f',
          child: Text(
            "Favorites Quotes",
            style: GoogleFonts.federo(),
          ),
        ),
      ),
      body: Obx(
            () => SingleChildScrollView(
              child: Column(
                        children: [
              SizedBox(
                height: size.height * 0.9,
                child: ListView.builder(
                  itemCount: _controller.allSaveQuotes.value.length,
                  itemBuilder: (context, index) {
                    Saves saves =
                    _controller.allSaveQuotes[index];
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://wallpaperset.com/w/full/3/2/6/248963.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.redAccent.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${saves.category} \n",
                              style: GoogleFonts.quattrocento(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text(
                            saves.quotes,
                            style: GoogleFonts.quattrocento(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "- ${saves.author}",
                              style: GoogleFonts.quattrocento(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
                        ],
                      ),
            ),
      ),
    );
  }
}

