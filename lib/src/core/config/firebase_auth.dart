import 'package:firebase_auth/firebase_auth.dart';

var acs = ActionCodeSettings(
    url: 'https://waytofit.page.link',
    handleCodeInApp: true,
    iOSBundleId: 'com.waytofit.wayToFit',
    androidPackageName: 'com.waytofit.way_to_fit',
    androidInstallApp: true,
    androidMinimumVersion: '5');
