import 'package:flutter_coffee_application/resource/services/api/category_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/category_model.dart';

final categoryServices =
    Provider<CategoryServices>((ref) => CategoryServices());
final categoryProvider = FutureProvider<List<ModelCategory>>((ref) async {
  return ref.read(categoryServices).getAllCategory();
});
