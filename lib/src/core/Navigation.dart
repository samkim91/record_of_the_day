
import 'package:flutter/material.dart';

enum NavigationBarItem {


  wod('WOD', Icons.rowing),
  rm('RM', Icons.fitness_center),
  profile('Profile', Icons.person);

  const NavigationBarItem(this.label, this.icon);

  final String label;
  final IconData icon;
}