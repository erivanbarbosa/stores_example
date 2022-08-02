import 'package:another_flushbar/flushbar_helper.dart';
import 'package:redesprou_boilerplate_name/data/sharedpref/constants/preferences.dart';
import 'package:redesprou_boilerplate_name/utils/routes/routes.dart';
import 'package:redesprou_boilerplate_name/stores/form/form_store.dart';
import 'package:redesprou_boilerplate_name/stores/theme/theme_store.dart';
import 'package:redesprou_boilerplate_name/utils/device/device_utils.dart';
import 'package:redesprou_boilerplate_name/utils/locale/app_localization.dart';
import 'package:redesprou_boilerplate_name/utils/url_utils.dart';
import 'package:redesprou_boilerplate_name/widgets/app_icon_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/empty_app_bar_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/fat_button.dart';
import 'package:redesprou_boilerplate_name/widgets/progress_indicator_widget.dart';
import 'package:redesprou_boilerplate_name/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late ThemeStore _themeStore;
  late FocusNode _passwordFocusNode;
  final _store = FormStore();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 60),
              child: AppIconWidget(image: 'assets/icons/ic_appicon.png'),
            ),
          ),
          Center(child: _buildRightSide()),
          Observer(
            builder: (context) {
              return _store.success ? navigate(context) : _showErrorMessage(_store.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.loading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          ),
          Align(alignment: Alignment.bottomCenter, child: _buildSignUpButton()),
        ],
      ),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 24.0),
            _buildUserIdField(),
            _buildPasswordField(),
            SizedBox(height: 40),
            _buildSignInButton(),
            _buildForgotPasswordButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('login_et_user_email'),
          inputType: TextInputType.emailAddress,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setUserId(_userEmailController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _store.formErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('login_et_user_password'),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          errorText: _store.formErrorStore.password,
          onChanged: (value) {
            _store.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: FractionalOffset.center,
      child: FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Text(
            AppLocalizations.of(context).translate('login_btn_forgot_password'),
            style: Theme.of(context).textTheme.caption?.copyWith(color: Color(0xFF4B0F7E)),
          ),
          onPressed: () {
            launchURL("https://webapp.gigwks.com.br/forgot-password");
          }),
    );
  }

  Widget _buildSignInButton() {
    return MainButton(
      buttonText: AppLocalizations.of(context).translate('login_btn_sign_in'),
      buttonColor: Color(0xFF4B0F7E),
      textColor: Colors.white,
      onPressed: () async {
        if (_store.canLogin) {
          DeviceUtils.hideKeyboard(context);
          _store.login();
        } else {
          _showErrorMessage('Please fill in all fields');
        }
      },
    );
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.dashboard, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  _buildSignUpButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      margin: const EdgeInsets.only(bottom: 40),
      width: double.infinity,
      child: MainButton(
        buttonText: AppLocalizations.of(context).translate('sign_up'),
        buttonColor: Colors.white,
        textColor: Theme.of(context).primaryColor,
        borderColor: Theme.of(context).primaryColor,
        onPressed: () async {
          final email = await Navigator.of(context).pushNamed(Routes.signup);
          setState(() {
            _userEmailController.text = email as String;
          });
        },
      ),
    );
  }
}
