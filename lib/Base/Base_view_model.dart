
import 'package:flutter/material.dart';
import 'package:tech_care/Base/Base_navigator.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier
{
   N? navigator;

}