import 'package:news_feed_app/controllers/fetch_news_controller.dart';

class SearchNewsController extends FetchNewsController {
  // ignore: unused_field
  var _searchValue = "";
  void setSearchValue(String val) {
    _searchValue = val;
  }
}
