import 'package:flutter_coffee_application/resource/model/promo_model.dart';
import 'package:flutter_coffee_application/resource/services/api/promo_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final promoServices = Provider<PromoServices>((ref) => PromoServices());
final promoProvider = FutureProvider<List<ModelPromo>>((ref) async {
  return ref.read(promoServices).getPromos();
});
final detailPromoProvider =
    FutureProvider.family<ModelPromo, String>((ref, promoId) async {
  var data = await ref.read(promoServices).getDetailParoki(promoId);
  return data;
});
final likePromo = StateProvider<List<bool>>((ref) => []);
final singleLikePost = StateProvider<bool>((ref) => false);