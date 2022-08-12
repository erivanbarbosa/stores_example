import 'package:get_it/get_it.dart';
import 'package:redesprou_boilerplate_name/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _FormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userEmail = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @computed
  bool get canLogin => !formErrorStore.hasErrorsInLogin && userEmail.isNotEmpty && password.isNotEmpty;

  @computed
  bool get canRegister => !formErrorStore.hasErrorsInRegister && userEmail.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty;

  @computed
  bool get canForgetPassword => !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "O email não pode ser vazio";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Por favor, insira um email válido';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "A senha não pode ser vazio";
    } else if (value.length < 6) {
      formErrorStore.password = "A senha precisa ter pelo menos 6 caracteres";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Confirmação de senha não pode ser vazia";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Senham não são iguais";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  @action
  Future register() async {
    loading = true;
  }

  @action
  Future login() async {
    loading = true;
    final getIt = GetIt.instance;
    bool result = true;

    Future.delayed(Duration(milliseconds: 2000)).then((future) {
      loading = false;
      success = result;

      if (!success) {
        errorStore.errorMessage = "Usuário e senha não combinam";
      }
    }).catchError((e) {
      loading = false;
      success = result;
      errorStore.errorMessage =
          e.toString().contains("ERROR_USER_NOT_FOUND") ? "Usuário e senha não combinam" : "Alguma coisa deu errado, cheque sua internet e tente novamente.";
      print(e);
    });
  }

  @action
  Future forgotPassword() async {
    loading = true;
  }

  @action
  Future logout() async {
    loading = true;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? userEmail;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInRegister => userEmail != null || password != null || confirmPassword != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;
}
