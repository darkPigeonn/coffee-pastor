import 'package:flutter_coffee_application/resource/model/notif_model.dart';
import 'package:flutter_coffee_application/resource/services/api/notification_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notifServices =
    Provider<NotificationServices>((ref) => NotificationServices());
final notifProvider = FutureProvider<List<ModelNotif>>((ref) async {
  var data = await ref.read(notifServices).fetchNotification();
  int count = data.where((notif) => notif.read == "").length;
  ref.watch(updateBadgeProvider.notifier).update((state) => count);
  return data;
});

final updateBadgeProvider = StateProvider<int>((ref) => 0);
