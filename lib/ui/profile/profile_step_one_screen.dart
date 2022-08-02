import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:redesprou_boilerplate_name/stores/post/post_store.dart';
import 'package:redesprou_boilerplate_name/stores/profile/profile_store.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/mask_utils.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/utils/string_utils.dart';
import 'package:redesprou_boilerplate_name/utils/translate_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/add_photo_button.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/profile_photo_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/form/form_section_title.dart';
import 'package:redesprou_boilerplate_name/widgets/generic_circular_progress_indicator.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/city_input.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/custom_date_picker.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/double_input_container.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/dropdown_input.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/input_inline_label.dart';
import 'package:redesprou_boilerplate_name/widgets/inputs/state_input.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ProfileStepOne extends StatefulWidget {
  const ProfileStepOne({Key? key}) : super(key: key);

  @override
  _ProfileStepOneState createState() => _ProfileStepOneState();
}

class _ProfileStepOneState extends State<ProfileStepOne> {
  late ProfileStore _profileStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profileStore = Provider.of<ProfileStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppScreen(
      screenTitle: "create_my_profile",
      screenBody: _profileStore.loading ? [] : _buildBody(),
      loading: _profileStore.loading,
    );
  }

  List<Widget> _buildBody() {
    return [
      _buildTitleMessage(),
      _buildAddPhotoButton(),
      _buildNameField(),
      SpacedWidget(_buildEmailField()),
      SpacedWidget(_buildPhoneField()),
      SpacedWidget(_buildGenreField()),
      SpacedWidget(_buildBirthdateRow()),
      SpacedWidget(_buildCPFField()),
      FormSectionTitle(title: translate(context, "social_media_platform")),
      _buildInstagramField(),
      SpacedWidget(_buildFacebookField()),
      FormSectionTitle(title: translate(context, "address")),
      _buildStateField(),
      Observer(builder: (context) {
        return SpacedWidget(_buildCityField());
      }),
      SpacedWidget(_buildZipField()),
      SpacedWidget(_buildAddressOneField()),
      SpacedWidget(_buildAddressTwoField()),
      SpacedWidget(_buildBioField()),
      SpacedWidget(_buildNextButton(), spaceBelow: true),
    ];
  }

  Widget _buildNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('name'),
          inputType: TextInputType.text,
          textController: _profileStore.nameController,
          //inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildPhoneField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('phone'),
          inputType: TextInputType.number,
          textController: _profileStore.phoneController,
          //inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
          inputFormatter: phoneMask,
        );
      },
    );
  }

  Widget _buildEmailField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('email'),
          inputType: TextInputType.emailAddress,
          textController: _profileStore.emailController,
          //inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildZipField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('zip_code'),
          inputType: TextInputType.number,
          textController: _profileStore.zipController,
          inputAction: TextInputAction.next,
          inputFormatter: zipMask,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildAddressOneField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('public_area'),
          inputType: TextInputType.text,
          textController: _profileStore.addressOneController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildAddressTwoField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('address_2'),
          inputType: TextInputType.text,
          textController: _profileStore.addressTwoController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildBirthdateRow() {
    return DoubleInputContainer(
      firstWidget: InputInlineLabel(label: "Nascimento"),
      secondWidget: _buildDateField(context),
      firstWidgetFlex: 3,
      secondWidgetFlex: 7,
    );
  }

  Container _buildTitleMessage() {
    return Container(
      child: Text(
        translate(context, "complete_your_personal_information"),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAddPhotoButton() {
    return Observer(builder: (context) {
      return _profileStore.imageLoading
          ? Container(height: 150, width: 150, child: Container(height: 50, width: 50, child: GenericCircularProgressIndicator()))
          : isBlank(_profileStore.profile!.profile_photo_path)
              ? AddPhotoButton(
                  iconName: "ic_profile",
                  label: translate(context, "add_photo"),
                  onTap: () async {
                    await _profileStore.addAvatar();
                    setState(() {});
                  },
                )
              : ProfilePhotoWidget(
                  profileImageUrl: _profileStore.profile!.profile_photo_path!,
                  onTap: () async {
                    await _profileStore.addAvatar();
                    setState(() {});
                  },
                );
    });
  }

  Widget _buildGenreField() {
    return DropdownInput(
      hint: AppLocalizations.of(context).translate('genre'),
      value: _profileStore.genre,
      items: [
        DropdownMenuItem(
          value: "MALE",
          child: Text(translate(context, 'male')),
        ),
        DropdownMenuItem(
          value: "FEMALE",
          child: Text(translate(context, 'female')),
        ),
        DropdownMenuItem(
          value: "UNDEFINED",
          child: Text(translate(context, 'undefined')),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _profileStore.genre = value!.isNotEmpty ? value : null;
        });
      },
    );
  }

  _buildDateField(context) {
    return Container(
      width: 100,
      child: CustomDatePicker(
          initialValue: _profileStore.birthDate,
          onDateSelected: (DateTime value) {
            _profileStore.birthDate = value;
          }),
    );
  }

  Widget _buildCPFField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('cpf'),
          inputType: TextInputType.number,
          textController: _profileStore.cpfController,
          //inputAction: TextInputAction.next,
          inputFormatter: cpfMask,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildInstagramField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate("profile_instagram"),
          inputType: TextInputType.text,
          textController: _profileStore.instagramController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildFacebookField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate("profile_facebook"),
          inputType: TextInputType.text,
          textController: _profileStore.facebookController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildBioField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate("description"),
          inputType: TextInputType.text,
          textController: _profileStore.bioController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
          minLines: 2,
          maxLines: 3,
          maxLength: 1000,
        );
      },
    );
  }

  Widget _buildStateField() {
    return Observer(builder: (context) {
      if (_profileStore.states == null) _profileStore.states = [];
      List<DropdownMenuItem<int>> stateList = _profileStore.states!.map((state) => DropdownMenuItem(value: state.id, child: Text(state.name!))).toList();

      return StateInput(
          states: stateList,
          value: _profileStore.state,
          onChanged: (value) {
            setState(() {
              _profileStore.city = null;
              _profileStore.state = value;
              _profileStore.findCities();
            });
          });
    });
  }

  Widget _buildCityField() {
    if (_profileStore.cities == null) _profileStore.cities = [];
    List<DropdownMenuItem<int>> cityList = _profileStore.cities!.map((city) => DropdownMenuItem(value: city.id, child: Text(city.name!))).toList();

    return Observer(builder: (context) {
      return CityInput(
          value: _profileStore.city,
          cities: cityList,
          onChanged: (value) {
            setState(() {
              _profileStore.city = value;
            });
          });
    });
  }

  Widget _buildNextButton() {
    return MainButton(
      buttonText: AppLocalizations.of(context).translate('next_step_one_of_two'),
      buttonColor: Colors.white,
      textColor: Theme.of(context).primaryColor,
      borderColor: Theme.of(context).primaryColor,
      onPressed: () async {
        pushNamed(context, Routes.profileStepTwo);
      },
    );
  }
}
