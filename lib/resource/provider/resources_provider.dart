import 'package:flutter_coffee_application/resource/model/resources_model.dart';
import 'package:flutter_coffee_application/resource/services/api/resources_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final detailArtikelData = FutureProvider.family<ModelResources1?, String>((ref, id) async {
  var data = await ResourceServices().fetchDetailArtikel(id);
  return data;
});

final artikelList = FutureProvider<List<ModelResources1>>((ref) async {
  List<ModelResources1> data = await ResourceServices().fetchAllArtikel();

  return data;
});

final featuredArtikelList = FutureProvider<List<ModelResources1>>((ref) async {
  List<ModelResources1> data = await ResourceServices().fetchFeaturedArtikel();
  return data;
});

final todayAgendasProvider = FutureProvider.family<AgendaModel, String>((ref, date) async {
  return await ResourceServices().getTodayAgenda(date);
});

final agendasProvider = FutureProvider((ref) async {
  return  await ResourceServices().getAgendas();
});