// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServiceListStore on _ServiceListStore, Store {
  final _$searchControllerAtom =
      Atom(name: '_ServiceListStore.searchController');

  @override
  TextEditingController get searchController {
    _$searchControllerAtom.reportRead();
    return super.searchController;
  }

  @override
  set searchController(TextEditingController value) {
    _$searchControllerAtom.reportWrite(value, super.searchController, () {
      super.searchController = value;
    });
  }

  final _$categoryAtom = Atom(name: '_ServiceListStore.category');

  @override
  int? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(int? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ServiceListStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$loadingMoreAtom = Atom(name: '_ServiceListStore.loadingMore');

  @override
  bool get loadingMore {
    _$loadingMoreAtom.reportRead();
    return super.loadingMore;
  }

  @override
  set loadingMore(bool value) {
    _$loadingMoreAtom.reportWrite(value, super.loadingMore, () {
      super.loadingMore = value;
    });
  }

  final _$imageLoadingAtom = Atom(name: '_ServiceListStore.imageLoading');

  @override
  bool get imageLoading {
    _$imageLoadingAtom.reportRead();
    return super.imageLoading;
  }

  @override
  set imageLoading(bool value) {
    _$imageLoadingAtom.reportWrite(value, super.imageLoading, () {
      super.imageLoading = value;
    });
  }

  final _$categoriesAtom = Atom(name: '_ServiceListStore.categories');

  @override
  List<IdAndName>? get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(List<IdAndName>? value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  final _$selectedCategoriesAtom =
      Atom(name: '_ServiceListStore.selectedCategories');

  @override
  List<IdAndName> get selectedCategories {
    _$selectedCategoriesAtom.reportRead();
    return super.selectedCategories;
  }

  @override
  set selectedCategories(List<IdAndName> value) {
    _$selectedCategoriesAtom.reportWrite(value, super.selectedCategories, () {
      super.selectedCategories = value;
    });
  }

  final _$serviceListAtom = Atom(name: '_ServiceListStore.serviceList');

  @override
  List<ServiceListItem> get serviceList {
    _$serviceListAtom.reportRead();
    return super.serviceList;
  }

  @override
  set serviceList(List<ServiceListItem> value) {
    _$serviceListAtom.reportWrite(value, super.serviceList, () {
      super.serviceList = value;
    });
  }

  final _$filterAtom = Atom(name: '_ServiceListStore.filter');

  @override
  ServiceFilter get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(ServiceFilter value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$pageAtom = Atom(name: '_ServiceListStore.page');

  @override
  CustomPage<dynamic> get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(CustomPage<dynamic> value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$getCategoriesAsyncAction =
      AsyncAction('_ServiceListStore.getCategories');

  @override
  Future getCategories() {
    return _$getCategoriesAsyncAction.run(() => super.getCategories());
  }

  final _$findServicesAsyncAction =
      AsyncAction('_ServiceListStore.findServices');

  @override
  Future findServices() {
    return _$findServicesAsyncAction.run(() => super.findServices());
  }

  final _$findMoreServicesAsyncAction =
      AsyncAction('_ServiceListStore.findMoreServices');

  @override
  Future findMoreServices() {
    return _$findMoreServicesAsyncAction.run(() => super.findMoreServices());
  }

  final _$_ServiceListStoreActionController =
      ActionController(name: '_ServiceListStore');

  @override
  dynamic reset() {
    final _$actionInfo = _$_ServiceListStoreActionController.startAction(
        name: '_ServiceListStore.reset');
    try {
      return super.reset();
    } finally {
      _$_ServiceListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchController: ${searchController},
category: ${category},
loading: ${loading},
loadingMore: ${loadingMore},
imageLoading: ${imageLoading},
categories: ${categories},
selectedCategories: ${selectedCategories},
serviceList: ${serviceList},
filter: ${filter},
page: ${page}
    ''';
  }
}
