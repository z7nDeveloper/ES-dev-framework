



import 'dart:math';

import 'package:flexible_structures/responsive/size_restriction_definition/restricted_size_profile.dart';


class RestrictSizeModel {


  final double realSize;
  final RestrictedSizeProfile restrictedSizeProfile;
  final Map<RestrictedSizeProfile, RestrictedSizeModelOption>? profileOptions;
  RestrictSizeModel({
    required this.restrictedSizeProfile,
    required this.realSize,
    this.profileOptions,
  });


  double value() {

    if(profileOptions?[restrictedSizeProfile] != null) {
      return profileOptions![restrictedSizeProfile]!.getValue(realSize);
    }

    return realSize;
  }
}


class RestrictedSizeModelOption {
  final double? maxValue;
  final double? minValue;

  const RestrictedSizeModelOption({
    this.maxValue,
    this.minValue,
});

  getValue(double value) {

    if(maxValue != null) {
      value = min(value, maxValue!);
    }
    if(minValue != null) {
      value = max(value, minValue!);
    }

    return value;
  }
}