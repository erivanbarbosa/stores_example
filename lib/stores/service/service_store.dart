import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/common/common_api.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/profile/profile_api.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/services/service_api.dart';
import 'package:redesprou_boilerplate_name/models/id_and_name.dart';
import 'package:redesprou_boilerplate_name/models/media.dart';
import 'package:redesprou_boilerplate_name/models/services/service.dart';
import 'package:redesprou_boilerplate_name/utils/image/imageUtils.dart';
import 'package:redesprou_boilerplate_name/utils/string_utils.dart';
import 'package:mobx/mobx.dart';

part 'service_store.g.dart';

class ServiceStore = _ServiceStore with _$ServiceStore;

abstract class _ServiceStore with Store {
  @observable
  TextEditingController serviceTitleController = TextEditingController();
  @observable
  TextEditingController serviceDescriptionController = TextEditingController();
  @observable
  TextEditingController serviceAddressOneController = TextEditingController();
  @observable
  TextEditingController serviceAddressTwoController = TextEditingController();
  @observable
  TextEditingController serviceGuaranteeController = TextEditingController();
  @observable
  TextEditingController serviceMyResponsibilityController = TextEditingController();
  @observable
  TextEditingController serviceCustomerResponsabilityController = TextEditingController();
  @observable
  TextEditingController serviceZipCodeController = TextEditingController();
  @observable
  bool home_care = false;
  @observable
  bool own_address = false;

  @observable
  bool loading = false;

  @observable
  bool imageLoading = false;

  @observable
  List<IdAndName>? categories = [];

  @observable
  List<int>? selectedCategories = [];

  @observable
  int? serviceId;

  ServiceApi _serviceApi = ServiceApi();

  ProfileApi _profileApi = ProfileApi();

  @observable
  List<IdAndName>? cities;

  @observable
  List<IdAndName>? states;

  @observable
  List<String> serviceImages = [];

  @observable
  List<Media>? medias;

  @observable
  int? state;

  @observable
  int? city;

  @observable
  List<String> daysOfWeek = [];

  @observable
  bool entireDay = false;

  @observable
  bool attendanceOnMorning = false;

  @observable
  bool attendanceOnAfternoon = false;

  @observable
  bool attendanceOnNight = false;

  @action
  Future<void> saveService() async {
    loading = true;
    Service service = Service(title: serviceTitleController.text, description: serviceDescriptionController.text, categories: selectedCategories);
    Service savedService = await _serviceApi.saveService(service).whenComplete(() => loading = false);
    serviceId = savedService.id;
    loading = false;
  }

  @action
  Future<void> updateService() async {
    loading = true;
    Service service = Service(
        title: serviceTitleController.text,
        description: serviceDescriptionController.text,
        categories: selectedCategories,
        address_1: serviceAddressOneController.text,
        address_2: serviceAddressTwoController.text,
        all_of_day: entireDay,
        attendance_on_afternoon: attendanceOnAfternoon,
        attendance_on_morning: attendanceOnMorning,
        attendance_on_night: attendanceOnNight,
        city_id: city,
        customer_responsibility: serviceCustomerResponsabilityController.text,
        days_of_week: daysOfWeek,
        home_care: home_care,
        my_responsibility: serviceMyResponsibilityController.text,
        own_address: own_address,
        service_guarantee: serviceGuaranteeController.text,
        zipcode: serviceZipCodeController.text);
    await _serviceApi.updateService(serviceId!, service).whenComplete(() => loading = false);
  }

  @action
  Future<void> deleteService(int serviceId) async {
    loading = true;
    await _serviceApi.deleteService(serviceId).whenComplete(() => loading = false);
  }

  @action
  getCategories() async {
    var categories = await _serviceApi.findCategories();
    this.categories = categories;
  }

  @action
  addImage() async {
    String image = await pickImage();
    imageLoading = true;
    Media media = await _serviceApi.addImage(serviceId!, image).whenComplete(() => imageLoading = false);
    serviceImages.add(media.url!);
    medias!.add(media);
  }

  @action
  deleteImage(int imageId) async {
    await _serviceApi.deleteImage(serviceId: serviceId!, imageId: imageId);
  }

  @action
  findCities() async {
    CommonApi commonApi = CommonApi();
    List<IdAndName> cities = await commonApi.findCities(stateId: state);
    this.cities = cities;
  }

  @action
  findStates() async {
    CommonApi commonApi = CommonApi();
    List<IdAndName> states = await commonApi.findStates();
    this.states = states;
  }

  @action
  loadForm(Service service) {
    serviceTitleController.text = service.title ?? "";
    serviceDescriptionController.text = service.description ?? "";
    serviceAddressOneController.text = service.address_1 ?? "";
    serviceAddressTwoController.text = service.address_2 ?? "";
    serviceGuaranteeController.text = service.service_guarantee ?? "";
    serviceMyResponsibilityController.text = service.my_responsibility ?? "";
    serviceCustomerResponsabilityController.text = service.customer_responsibility ?? "";
    serviceZipCodeController.text = service.zipcode ?? "";
    home_care = service.home_care ?? false;
    own_address = service.own_address ?? false;
    loading = false;
    imageLoading = false;
    selectedCategories = service.categories ?? [];
    serviceId = service.id;
    serviceImages = service.medias != null ? service.medias!.map((e) => e.url!).toList() : [];
    medias = service.medias ?? [];
    _resolveStateAndCity(service);
    daysOfWeek = service.days_of_week ?? [];
    entireDay = service.all_of_day ?? false;
    attendanceOnMorning = service.attendance_on_morning ?? false;
    attendanceOnAfternoon = service.attendance_on_afternoon ?? false;
    attendanceOnNight = service.attendance_on_night ?? false;
  }

  void _resolveStateAndCity(Service service) async {
    int? stateId = service.state != null ? service.state!.id : service.state_id;
    if (stateId != null) {
      CommonApi commonApi = CommonApi();
      if (isBlankList(states)) states = await commonApi.findStates();
      cities = await commonApi.findCities(stateId: stateId);
    }

    state = stateId;
    city = service.city != null ? service.city!.id : service.city_id;
  }

  @action
  reset() {
    serviceTitleController = TextEditingController();
    serviceDescriptionController = TextEditingController();
    serviceAddressOneController = TextEditingController();
    serviceAddressTwoController = TextEditingController();
    serviceGuaranteeController = TextEditingController();
    serviceMyResponsibilityController = TextEditingController();
    serviceCustomerResponsabilityController = TextEditingController();
    serviceZipCodeController = TextEditingController();
    home_care = false;
    own_address = false;
    loading = false;
    imageLoading = false;
    selectedCategories = [];
    serviceId = null;
    serviceImages = [];
    state = null;
    city = null;
    daysOfWeek = [];
    entireDay = false;
    attendanceOnMorning = false;
    attendanceOnAfternoon = false;
    attendanceOnNight = false;
    medias = [];
  }

  @action
  resetAddress() {
    serviceAddressOneController = TextEditingController();
    serviceAddressTwoController = TextEditingController();
    serviceZipCodeController = TextEditingController();
    state = null;
    city = null;
  }

  @action
  Future<Service> findService(int serviceId) async {
    loading = true;
    Service service = await _serviceApi.findService(serviceId).whenComplete(() => loading = false);
    return service;
  }
}
