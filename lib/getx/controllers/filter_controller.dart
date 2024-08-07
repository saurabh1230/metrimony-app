
import 'package:bureau_couple/getx/repository/repo/matches_repo.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

import '../../src/models/matches_model.dart';




class FilterController extends GetxController implements GetxService {

  FilterController();


  bool _isLoading = false;
  bool get isLoading => _isLoading;


  final List<String> _filterReligion = [];
  List<String> get filterReligion => _filterReligion;

  void setFilterReligion(String val) {
    if (_filterReligion.contains(val)) {
      _filterReligion.remove(val);
    } else {
      _filterReligion.add(val);
    }
    update();
  }

  final List<String> _filterCommunity = [];
  List<String> get filterCommunity => _filterCommunity;

  void setFilterCommunity(String val) {
    if (_filterCommunity.contains(val)) {
      _filterCommunity.remove(val);
    } else {
      _filterCommunity.add(val);
    }
    update();
  }

  final List<String> _filterMotherTongue = [];
  List<String> get filterMotherTongue => _filterMotherTongue;

  void setFilterMotherTongue(String val) {
    if (_filterMotherTongue.contains(val)) {
      _filterMotherTongue.remove(val);
    } else {
      _filterMotherTongue.add(val);
    }
    update();
  }

  final List<String> _filterProfession = [];
  List<String> get filterProfession => _filterProfession;

  void setFilterProfession(String val) {
    if (_filterProfession.contains(val)) {
      _filterProfession.remove(val);
    } else {
      _filterProfession.add(val);
    }
    update();
  }

  bool isExpanded = false;
  void toggleExpanded() {
    isExpanded = !isExpanded;
    update();
  }

}

