import 'package:get/get.dart';
import '../helper/api_helper.dart';
import '../modal/api.dart';

class ApiController extends GetxController {
  RxList allData = [].obs;
  RxString category = "".obs;

  List<ApiModal>? allQuotes;

  searchCategory({required String category}) {
    this.category(category);
  }

  Future<void> getData() async {
    allQuotes = await ApiHelper.apiHelper.getApi();
    allData(allQuotes);
  }
}