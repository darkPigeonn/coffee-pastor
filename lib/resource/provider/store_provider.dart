import 'package:flutter_coffee_application/resource/model/store_model.dart';
import 'package:flutter_coffee_application/resource/services/api/store_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final storeServices =
    Provider<StoreServices>((ref) => StoreServices());
final storeProvider = FutureProvider<List<ModelStore>>((ref) async {
  return ref.read(storeServices).getAllStore();
});
