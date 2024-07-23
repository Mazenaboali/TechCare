
import 'package:flutter/material.dart';
import 'package:tech_care/domain/Base_navigator.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier
{
   N? navigator;

}