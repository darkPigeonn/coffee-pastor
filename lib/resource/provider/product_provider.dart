import 'package:flutter_coffee_application/resource/model/product_model.dart';
import 'package:flutter_coffee_application/resource/services/api/product_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productServices = Provider<ProductServices>((ref) => ProductServices());
final productProvider =
    FutureProvider.family<List<ModelProduct>, String>((ref, category) async {
  var data = await ref.read(productServices).getProductCategory(category);
  return data;
});

final countItemProvider = StateProvider<List<int>>((ref) => []);
