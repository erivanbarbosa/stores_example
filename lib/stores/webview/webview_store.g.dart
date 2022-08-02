// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webview_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WebviewStore on _WebviewStore, Store {
  final _$insuranceUrlAtom = Atom(name: '_WebviewStore.insuranceUrl');

  @override
  String? get insuranceUrl {
    _$insuranceUrlAtom.reportRead();
    return super.insuranceUrl;
  }

  @override
  set insuranceUrl(String? value) {
    _$insuranceUrlAtom.reportWrite(value, super.insuranceUrl, () {
      super.insuranceUrl = value;
    });
  }

  final _$creditUrlAtom = Atom(name: '_WebviewStore.creditUrl');

  @override
  String? get creditUrl {
    _$creditUrlAtom.reportRead();
    return super.creditUrl;
  }

  @override
  set creditUrl(String? value) {
    _$creditUrlAtom.reportWrite(value, super.creditUrl, () {
      super.creditUrl = value;
    });
  }

  final _$loadingAtom = Atom(name: '_WebviewStore.loading');

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

  final _$getInsuranceUrlAsyncAction =
      AsyncAction('_WebviewStore.getInsuranceUrl');

  @override
  Future getInsuranceUrl() {
    return _$getInsuranceUrlAsyncAction.run(() => super.getInsuranceUrl());
  }

  @override
  String toString() {
    return '''
insuranceUrl: ${insuranceUrl},
creditUrl: ${creditUrl},
loading: ${loading}
    ''';
  }
}
