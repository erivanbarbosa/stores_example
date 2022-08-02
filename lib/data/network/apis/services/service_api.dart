import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redesprou_boilerplate_name/data/network/apis/common/custom_page.dart';
import 'package:redesprou_boilerplate_name/data/network/constants/endpoints.dart';
import 'package:redesprou_boilerplate_name/models/id_and_name.dart';
import 'package:redesprou_boilerplate_name/models/media.dart';
import 'package:redesprou_boilerplate_name/models/services/service.dart';
import 'package:redesprou_boilerplate_name/models/services/service_filter.dart';
import 'package:redesprou_boilerplate_name/models/services/service_list_item.dart';
import 'package:redesprou_boilerplate_name/utils/credential_utils.dart';
import 'package:redesprou_boilerplate_name/utils/error_utils.dart';
import 'package:redesprou_boilerplate_name/utils/message_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ServiceApi {
  Future<List<IdAndName>> findCategories() async {
    final uri = Uri.parse(Endpoints.categories);
    Map<String, String> headers = await getHeaders();
    Response response = await http.get(uri, headers: headers);
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      final String res = response.body;
      Map<String, dynamic> result = jsonDecode(res);
      List data = result['data'];
      var categories = data.map((x) => IdAndName.fromMap(x)).toList();
      return categories;
    } else {
      throw "erro";
    }
  }

  Future<Service> saveService(Service service) async {
    return tryCatch(() async {
      final uri = Uri.parse(Endpoints.services);
      Map<String, String> headers = await getHeaders();
      Response response = await http.post(uri, body: service.toJson(), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final String res = response.body;
        Map<String, dynamic> result = jsonDecode(res);
        var data = result['data'];
        Service service = Service.fromMap(data);
        showSuccessMessage();
        return service;
      } else {
        throw Exception(getResponseErroMessage(response.body));
      }
    });
  }

  Future<CustomPage<ServiceListItem>> findServices(ServiceFilter filter, CustomPage page) async {
    return tryCatch(() async {
      final String _url = "${Endpoints.services}${filter.joinUrlParams()}${page.joinUrlParams()}";
      String url = _url.replaceAll("?", "&").replaceFirst("&", "?");
      final uri = Uri.parse(url);
      Map<String, String> headers = await getHeaders();
      Response response = await http.get(uri, headers: headers);
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        final String res = response.body;
        Map<String, dynamic> result = jsonDecode(res);
        List data = result['data'];
        List<ServiceListItem> services = data.map((x) => ServiceListItem.fromMap(x)).toList();
        CustomPage<ServiceListItem> page = CustomPage.fromMap(result['meta']);
        page.items = services;
        return page;
      } else {
        throw "erro";
      }
    });
  }

  Future<void> updateService(int serviceId, Service service) async {
    return tryCatch(() async {
      final uri = Uri.parse(Endpoints.updateService(serviceId));
      Map<String, String> headers = await getHeaders();
      Response response = await http.put(uri, body: service.toJson(), headers: headers);
      response.statusCode == 200 ? showSuccessMessage() : throw Exception(getResponseErroMessage(response.body));
    });
  }

  Future<Media> addImage(int serviceId, String image) async {
    final uri = Uri.parse(Endpoints.serviceMedia(serviceId));
    Map<String, String> headers = await getHeaders();
    Map<String, String> body = {"name": "service-image", "media": "data:image/jpeg;base64,$image"};
    Response response = await http.post(uri, body: jsonEncode(body), headers: headers);
    final int statusCode = response.statusCode;
    if (statusCode == 200 || statusCode == 201) {
      final String res = response.body;
      Map<String, dynamic> result = jsonDecode(res);
      Media media = Media(id: result['id'], url: result['media']);
      return media;
    } else {
      throw "erro";
    }
  }

  Future<void> deleteImage({required int serviceId, required int imageId}) async {
    final uri = Uri.parse(Endpoints.deleteMedia(serviceId: serviceId, mediaId: imageId));
    Map<String, String> headers = await getHeaders();
    Response response = await http.delete(uri, headers: headers);
    if (response.statusCode != 200) {
      throw "Error";
    }
  }

  Future<void> deleteService(int serviceId) async {
    return tryCatch(() async {
      final uri = Uri.parse(Endpoints.deleteService(serviceId));
      Map<String, String> headers = await getHeaders();
      Response response = await http.delete(uri, headers: headers);
      response.statusCode == 200 ? showDeleteSuccessMessage() : throw Exception(getResponseErroMessage(response.body));
    });
  }

  Future<Service> findService(int id) async {
    return tryCatch(() async {
      final uri = Uri.parse(Endpoints.findService(id));
      Map<String, String> headers = await getHeaders();
      Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final String res = response.body;
        Map<String, dynamic> result = jsonDecode(res);
        Service service = Service.fromMap(result['data']);
        return service;
      } else {
        throw Exception(getResponseErroMessage(response.body));
      }
    });
  }
}
