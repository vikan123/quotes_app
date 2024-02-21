import 'package:get/get.dart';
import 'package:quotes_app/helper/db_helper.dart';
import 'package:quotes_app/modal/saves_screen.dart';


class SaveController extends GetxController {
  RxList<Saves> allSaveQuotes = <Saves>[].obs;

  get getAllFavoritesQuotes async {
    return allSaveQuotes(await DBHelper.dbHelper.displayLikeQuotes() ??[]);
  }
}