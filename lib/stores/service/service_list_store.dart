import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/common/custom_page.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/services/service_api.dart';
import 'package:redesprou_boilerplate_name/models/id_and_name.dart';
import 'package:redesprou_boilerplate_name/models/services/service_list_item.dart';
import 'package:mobx/mobx.dart';
import 'package:redesprou_boilerplate_name/models/services/service_filter.dart';

part 'service_list_store.g.dart';

class ServiceListStore = _ServiceListStore with _$ServiceListStore;

abstract class _ServiceListStore with Store {
  @observable
  TextEditingController searchController = TextEditingController();

  @observable
  int? category;

  @observable
  bool loading = false;

  @observable
  bool loadingMore = false;

  @observable
  bool imageLoading = false;

  @observable
  List<IdAndName>? categories = [];

  @observable
  List<IdAndName> selectedCategories = [];

  @observable
  List<ServiceListItem> serviceList = [];

  @observable
  ServiceFilter filter = ServiceFilter();

  @observable
  CustomPage page = CustomPage(page: 1, per_page: 15);

  ServiceApi _serviceApi = ServiceApi();

  @action
  getCategories() async {
    var categories = await _serviceApi.findCategories();
    this.categories = categories;
  }

  @action
  findServices() async {
    loading = true;
    filter.categories = selectedCategories.map((e) => e.id!).toList();
    CustomPage<ServiceListItem> page = await _serviceApi.findServices(filter, this.page).whenComplete(() => loading = false);
    this.serviceList = page.items ?? [];
    this.page.last_page = page.last_page;
    this.page.total = page.total;
  }

  @action
  findMoreServices() async {
    if (this.page.page == 1 || this.page.page! < this.page.last_page!) {
      loadingMore = true;
      this.page.page = this.page.page! + 1;
      CustomPage<ServiceListItem> page = await _serviceApi.findServices(filter, this.page).whenComplete(() => loadingMore = false);
      this.serviceList.addAll(page.items ?? []);
      this.page.last_page = page.last_page;
      this.page.total = page.total;
    }
  }

  @action
  reset() {
    searchController = TextEditingController();
    loading = false;
    loadingMore = false;
    imageLoading = false;
    categories = [];
    selectedCategories = [];
    serviceList = [];
    filter = ServiceFilter();
  }
}
