import 'dart:io';

import 'package:flutter_coffee_application/resource/model/user_model.dart';
import 'package:flutter_coffee_application/resource/services/api/profile_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileDataProvider = FutureProvider<ModelUser>((ref) async {
  ModelUser data = await profileServices().fetchProfile();
  return data;
});

final imagePicked = StateProvider<File?>((ref) => null);

final isAdminProvider = StateProvider<bool>((ref) => false);
