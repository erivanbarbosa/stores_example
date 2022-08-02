import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:redesprou_boilerplate_name/models/id_and_name.dart';
import 'package:redesprou_boilerplate_name/models/services/service.dart';
import 'package:redesprou_boilerplate_name/models/services/service_list_item.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_list_store.dart';
import 'package:redesprou_boilerplate_name/stores/service/service_store.dart';
import 'package:redesprou_boilerplate_name/ui/services/service_resume.dart';
import 'package:redesprou_boilerplate_name/utils/debouncer.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/tag_button.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/generic_circular_progress_indicator.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/generic_dropdown_input.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({Key? key}) : super(key: key);

  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  late ServiceListStore _serviceListStore;
  late ServiceStore _serviceStore;
  Debouncer debouncer = Debouncer();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _serviceListStore = Get.find();
    _serviceStore = Get.find();
    _serviceListStore.page.page = 1;
    _serviceListStore.loading = false;
    _serviceListStore.loadingMore = false;
    _serviceListStore.reset();
    _serviceListStore.findServices();
    _serviceListStore.getCategories();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return DefaultAppScreen(
          screenTitle: "services",
          screenBody: _buildBody(),
          contentAlign: Alignment.topCenter,
        );
      },
    );
  }

  List<Widget> _buildBody() {
    return [
      _buildSearchField(),
      SpacedWidget(_buildCategoryField()),
      SpacedWidget(_buildTagButtons()),
      Observer(builder: (context) {
        return _serviceListStore.loading
            ? Container(height: MediaQuery.of(context).size.height - 400, child: GenericCircularProgressIndicator())
            : _buildList();
      })
    ];
  }

  Observer _buildList() {
    return Observer(builder: (context) {
      return _serviceListStore.serviceList.length > 0
          ? Container(
              height: MediaQuery.of(context).size.height - 150,
              child: NotificationListener(
                onNotification: (ScrollNotification notification) => _handleLoadMore(notification, context),
                child: RefreshIndicator(
                  onRefresh: _findServices,
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: _serviceListStore.serviceList.length,
                        itemBuilder: (context, index) {
                          return _buildListTile(_serviceListStore.serviceList[index]);
                        },
                      ),
                      Visibility(
                        visible: _serviceListStore.loadingMore,
                        child: GenericCircularProgressIndicator(),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height - 200,
              child: Center(child: Text("Nenhum item encontrado")),
            );
    });
  }

  Observer _buildTagButtons() {
    return Observer(
      builder: (context) {
        List<TagButton> buttons = _serviceListStore.selectedCategories
            .map((e) => TagButton(
                text: e.name ?? "",
                onTap: () {
                  _serviceListStore.selectedCategories.remove(e);
                  _serviceListStore.findServices();
                  setState(() {});
                }))
            .toList();

        return Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          height: 30,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: buttons,
          ),
        );
      },
    );
  }

  Widget _buildSearchField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('search'),
          inputType: TextInputType.text,
          textController: _serviceListStore.searchController,
          //inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {
            _serviceListStore.filter.s = _serviceListStore.searchController.text;
            _serviceListStore.findServices();
          },
          errorText: null,
        );
      },
    );
  }

  Widget _buildCategoryField() {
    return Observer(builder: (context) {
      if (_serviceListStore.categories == null) _serviceListStore.categories = [];
      List<IdAndName> filteredCategories = _serviceListStore.categories!.where((element) => !_serviceListStore.selectedCategories.contains(element)).toList();
      List<DropdownMenuItem<int>> categoryList =
          filteredCategories.map((category) => DropdownMenuItem(value: category.id, child: Text(category.name!))).toList();

      return GenericDropdownInput<int>(
          hint: AppLocalizations.of(context).translate('category'),
          value: _serviceListStore.category,
          items: categoryList,
          onChanged: (value) {
            setState(() {
              _serviceListStore.selectedCategories.add(_serviceListStore.categories!.firstWhere((element) => element.id == value));
              _serviceListStore.page.page = 1;
              _serviceListStore.findServices();
            });
          });
    });
  }

  Future<void> _findServices() async {
    _serviceListStore.page.page = 1;
    return _serviceListStore.findServices();
  }

  bool _handleLoadMore(ScrollNotification scrollNotification, BuildContext context) {
    bool listIsToSmallToScroll = scrollNotification.metrics.extentBefore == 0 && scrollNotification.metrics.extentAfter == 0;
    bool userGestureIsToBottom = scrollNotification is UserScrollNotification && scrollNotification.direction == ScrollDirection.reverse;
    if (userGestureIsToBottom) {
      if (listIsToSmallToScroll) {
        _loadMore();
      } else {
        double contentBelowViewportHeight = scrollNotification.metrics.extentAfter;
        double offsetToCallNextPage = 0.40 * scrollNotification.metrics.viewportDimension;
        if (contentBelowViewportHeight < offsetToCallNextPage) {
          _loadMore();
        }
      }
    }

    return false;
  }

  Future<void> _loadMore() async {
    await this.debouncer.debounce(Duration(milliseconds: 300), () {
      _serviceListStore.findMoreServices();
    });
  }

  _buildListTile(ServiceListItem item) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10, top: 10),
      title: Text(item.title ?? ""),
      leading: _buildAvatar(item),
      subtitle: Text(item.service_provider_name!),
      horizontalTitleGap: 20,
      onTap: () async {
        _serviceListStore.loading = true;
        Service service = await _serviceStore.findService(item.id!).whenComplete(() => _serviceListStore.loading = false);
        Navigator.push(
            context,
            MaterialPageRoute(
              settings: RouteSettings(name: Routes.serviceResume),
              builder: (context) => ServiceResumeScree(service: service, visualize: true),
            ));
      },
    );
  }

  CircleAvatar _buildAvatar(ServiceListItem item) {
    return CircleAvatar(
      radius: 30.0,
      backgroundImage: _buildPhoto(item),
    );
  }

  _buildPhoto(ServiceListItem item) {
    return item.service_provider_profile_photo_path != null
        ? NetworkImage(item.service_provider_profile_photo_path!)
        : AssetImage('assets/icons/Profile_Ilustration.png');
  }
}
