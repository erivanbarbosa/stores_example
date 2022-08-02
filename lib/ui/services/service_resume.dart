import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:redesprou_boilerplate_name/models/services/service.dart';
import 'package:redesprou_boilerplate_name/models/services/service_user.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_store.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/string_utils.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/form/form_section_title.dart';
import 'package:redesprou_boilerplate_name/widgets/image_gallery.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/texts/center_text.dart';
import 'package:redesprou_boilerplate_name/widgets/texts/title_message.dart';

class ServiceResumeScree extends StatefulWidget {
  final Service service;
  final double fontSize = 18;
  final bool visualize;

  const ServiceResumeScree({
    Key? key,
    required this.service,
    this.visualize = false,
  }) : super(key: key);

  @override
  _ServiceResumeScreeState createState() => _ServiceResumeScreeState();
}

class _ServiceResumeScreeState extends State<ServiceResumeScree> {
  late ServiceStore _serviceStore;
  double formSectionTitleSize = 20;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _serviceStore = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppScreen(
      screenTitle: "service",
      screenBody: _buildBody(context),
      contentAlign: Alignment.topCenter,
    );
  }

  List<Widget> _buildBody(context) {
    return [
      SizedBox(height: 30),
      _buildTitleRow(),
      CenterText(
        text: widget.service.description!,
        fontSize: 16,
      ),
      SizedBox(height: 30),
      if (isNotBlankList(widget.service.categories!)) CenterText(text: widget.service.serviceCategories!.map((e) => e.name).join(", ")),
      if (widget.service.home_care!) CenterText(text: translate(context, "at_house")),
      if (widget.service.own_address!) CenterText(text: translate(context, "at_home")),
      SizedBox(height: 20),
      if (_showLocation()) _buildLocation(),
      if (_showAvailability()) _buildAvailability(),
      if (isNotBlank(widget.service.service_guarantee)) _buildGuarantee(),
      if (isNotBlank(widget.service.my_responsibility)) _buildMyResponsability(),
      if (widget.service.customer_responsibility != null) _buildCustomerResponsability(),
      if (isNotBlankList(widget.service.medias!)) _buildImageGallery(),
      if (widget.visualize == true) _buildTelephoneField()
    ];
  }

  Widget _buildTitleRow() {
    return Stack(
      alignment: Alignment.center,
      children: [
        TitleMessage(title: widget.service.title!),
        Visibility(
          visible: widget.visualize == false,
          child: Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                _serviceStore.loadForm(widget.service);
                pushNamed(context, Routes.serviceStepOne);
              },
              icon: Icon(Icons.edit),
            ),
          ),
        ),
      ],
    );
  }

  CenterText _getDaysOfWeek(context) {
    List<String> translateddDays = widget.service.days_of_week!.map((e) => translate(context, e)).toList();
    return CenterText(text: translateddDays.join(", "));
  }

  bool _showLocation() {
    return isNotBlank(widget.service.zipcode) || isNotBlank(widget.service.address_1) || isNotBlank(widget.service.address_2);
  }

  _buildLocation() {
    return Column(
      children: [
        SpacedWidget(FormSectionTitle(
          title: "Localização",
          alignment: TextAlign.center,
          top: 0,
          bottom: 0,
          fontSize: widget.fontSize,
        )),
        if (isNotBlank(widget.service.zipcode)) CenterText(text: widget.service.zipcode!),
        if (isNotBlank(widget.service.address_1)) CenterText(text: widget.service.address_1!),
        if (isNotBlank(widget.service.address_2)) CenterText(text: widget.service.address_2!),
        SizedBox(height: 20)
      ],
    );
  }

  bool _showAvailability() {
    return isNotBlankList(widget.service.days_of_week) ||
        isTrue(widget.service.all_of_day) ||
        isTrue(widget.service.attendance_on_morning) ||
        isTrue(widget.service.attendance_on_afternoon) ||
        isTrue(widget.service.attendance_on_night);
  }

  _buildAvailability() {
    return Column(
      children: [
        SpacedWidget(FormSectionTitle(
          title: translate(context, "availability"),
          alignment: TextAlign.center,
          top: 0,
          bottom: 0,
          fontSize: widget.fontSize,
        )),
        if (isNotBlankList(widget.service.days_of_week!)) _getDaysOfWeek(context),
        if (widget.service.all_of_day != null && widget.service.all_of_day!) CenterText(text: translate(context, "entire_day")),
        if (widget.service.attendance_on_morning != null && widget.service.attendance_on_morning!) CenterText(text: translate(context, "morning")),
        if (widget.service.attendance_on_afternoon != null && widget.service.attendance_on_afternoon!) CenterText(text: translate(context, "evening")),
        if (widget.service.attendance_on_night != null && widget.service.attendance_on_night!) CenterText(text: translate(context, "night_period")),
        SizedBox(height: 20)
      ],
    );
  }

  _buildGuarantee() {
    return Column(
      children: [
        SpacedWidget(FormSectionTitle(
          title: "Garantia e Recursos",
          alignment: TextAlign.center,
          top: 0,
          bottom: 0,
          fontSize: widget.fontSize,
        )),
        CenterText(text: widget.service.service_guarantee!),
        SizedBox(height: 20)
      ],
    );
  }

  _buildMyResponsability() {
    return Column(
      children: [
        SpacedWidget(FormSectionTitle(
          title: translate(context, "on_me"),
          alignment: TextAlign.center,
          top: 0,
          bottom: 0,
          fontSize: widget.fontSize,
        )),
        CenterText(text: widget.service.my_responsibility!),
        SizedBox(height: 20)
      ],
    );
  }

  _buildCustomerResponsability() {
    return Column(
      children: [
        SpacedWidget(FormSectionTitle(
          title: translate(context, "on_client"),
          alignment: TextAlign.center,
          top: 0,
          bottom: 0,
          fontSize: widget.fontSize,
        )),
        CenterText(text: widget.service.customer_responsibility!),
        SizedBox(height: 20)
      ],
    );
  }

  _buildImageGallery() {
    return Container(
        margin: EdgeInsets.only(top: 30, bottom: 30),
        height: 350,
        child: ImageGallery(
          count: 3,
          medias: widget.service.medias!,
        ));
  }

  _buildTelephoneField() {
    ServiceUser? user = widget.service.user;

    return user != null
        ? Column(
            children: [
              CenterText(text: user.name ?? "", fontSize: 16),
              CenterText(text: user.phone ?? "", fontSize: 16),
              CenterText(text: user.email ?? "", fontSize: 16),
            ],
          )
        : Container();
  }
}
