import 'package:get/get.dart';
import 'package:quotes_app/helper/db_helper.dart';
import 'package:quotes_app/modal/quetes_modal.dart';

class QuotesController extends GetxController {
  RxList<QuotesModals> allHistoryQuotes = <QuotesModals>[].obs;

  get getAllHistoryQuotes async {
    return allHistoryQuotes(await DBHelper.dbHelper.displayQuotes()??[]);
  }
}