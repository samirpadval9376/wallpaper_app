import 'package:flutter/cupertino.dart';
import 'package:wallpaper_app/controllers/helpers/api_helper.dart';
import 'package:wallpaper_app/modals/post_modal.dart';

class ApiController extends ChangeNotifier {
  List data = [];
  List favourite = [];

  ApiController() {
    search();
  }

  search({String val = "nature"}) async {
    data = await ApiHelper.apiHelper.wallpaper(query: val) ?? [];
    notifyListeners();
    return 0;
  }

  addFavourite({required int index}) {
    favourite.add(index);
    notifyListeners();
  }
}
