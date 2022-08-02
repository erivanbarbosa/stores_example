import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:redesprou_boilerplate_name/stores/profile/profile_store.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/navigation_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/buttons/flat_text_button.dart';
import 'package:redesprou_boilerplate_name/widgets/default_app_screen.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/generic_circular_progress_indicator.dart';
import 'package:redesprou_boilerplate_name/widgets/spaced_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late ProfileStore _profileStore;

  bool _agreementChecked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profileStore = Provider.of<ProfileStore>(context);
    _profileStore.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return DefaultAppScreen(
          screenTitle: "sign_up_screen_title",
          screenBody: _profileStore.loading ? [GenericCircularProgressIndicator()] : _buildBody(),
        );
      },
    );
  }

  _buildBody() {
    return [
      SpacedWidget(_buildNameField()),
      SpacedWidget(_buildEmailField()),
      SpacedWidget(_buildPasswordField()),
      SpacedWidget(_buildConfirmPasswordField()),
      SpacedWidget(_buildAgreementCheckbox()),
      SpacedWidget(_buildSignUpButton())
    ];
  }

  Widget _buildNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('name'),
          inputType: TextInputType.text,
          textController: _profileStore.nameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
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
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('password'),
          inputType: TextInputType.text,
          isObscure: true,
          textController: _profileStore.passwordController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('confirm_password'),
          inputType: TextInputType.text,
          isObscure: true,
          textController: _profileStore.confirmPasswordController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
          onFieldSubmitted: (value) {},
          errorText: null,
        );
      },
    );
  }

  Widget _buildAgreementCheckbox() {
    return CheckboxListTile(
        contentPadding: EdgeInsets.all(0),
        title: Row(
          children: [
            Text(AppLocalizations.of(context).translate('agreement_with')),
            _buildForgotPasswordButton(),
          ],
        ),
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.blueAccent,
        value: _agreementChecked,
        onChanged: (value) {
          setState(() {
            _agreementChecked = value!;
          });
        });
  }

  Widget _buildForgotPasswordButton() {
    return FlatTextButton(
      text: AppLocalizations.of(context).translate('use_terms'),
      color: Theme.of(context).primaryColor,
    );
  }

  Widget _buildSignUpButton() {
    return MainButton(
      buttonText: AppLocalizations.of(context).translate('register'),
      buttonColor: Color(0xFF4B0F7E),
      textColor: Colors.white,
      onPressed: () async {
        await _profileStore.createProfile().then((value) => pop(context, data: _profileStore.emailController.text));
      },
    );
  }
}
