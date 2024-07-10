import 'package:flutter_coffee_application/resource/model/testimoni_model.dart';
import 'package:flutter_coffee_application/resource/services/api/testimoni_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final testimoniServices = Provider<TestimoniServices>((ref) => TestimoniServices());
final testimoniProvider = FutureProvider<List<ModelTestimoni>>((ref) async {
  return ref.read(testimoniServices).getActiveTestimonis();
});
final detailTestimoniProvider =
    FutureProvider.family<ModelTestimoni, String>((ref, id) async {
  var data = await ref.read(testimoniServices).getDetailTestimoni(id);
  return data;
});