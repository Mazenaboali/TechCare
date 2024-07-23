import 'package:flutter/material.dart';
import 'package:tech_care/domain/Base_navigator.dart';
import 'package:tech_care/presentation/Base_view_model.dart';
import 'package:tech_care/domain/utils/dialog_utils.dart';

abstract class BaseState<T extends StatefulWidget, vm extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late vm viewmodel;
  vm initviewmodel();

  @override
  void initState() {
    super.initState();
    viewmodel = initviewmodel();
    viewmodel.navigator = this;
  }

  @override
  void HideDialog() {
    dialogUtils.hideDialog(context);
  }

  @override
  void ShowMessage(String title,
      {String? posaction,
      String? negaction,
      bool isDismisible = false}) {
    dialogUtils.showMessage(context, title, posaction: posaction);
  }

  @override
  void ShowProgressDialog(String Message, {bool isDismisble = false}) {
    dialogUtils.ShowProgressDialog(context, Message);
  }
}
