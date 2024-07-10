import 'package:flutter_coffee_application/resource/model/tentang_model.dart';
import 'package:flutter_coffee_application/resource/services/api/tentang_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDelivProvider = StateProvider<bool>((ref) => false);

final tentangServices = Provider<TentangServices>((ref) => TentangServices());
final tentangProvider = FutureProvider<ModelTentang>((ref) async {
  return ref.read(tentangServices).getContent();
});

final detailParokiData = FutureProvider.family<Paroki, String>((ref, ParokiId) async {
  return await ref.read(tentangServices).getDetailParoki(ParokiId);
});