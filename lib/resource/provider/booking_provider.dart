import 'package:flutter_coffee_application/resource/model/booking_model.dart';
import 'package:flutter_coffee_application/resource/services/api/booking_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingServices = Provider<BookingServices>((ref) => BookingServices());
final bookingProvider = FutureProvider<List<ModelBooking>>((ref) async {
  return await ref.read(bookingServices).getUserBooking();
});
final detailBookingProvider =
    FutureProvider.family<ModelBooking, String>((ref, id) async {
  var data = await ref.read(bookingServices).getDetailBooking(id);
  return data;
});

final approveBookingProvider =
    FutureProvider.family<List<ModelBooking>, String>((ref, date) async {
  var data = await ref.read(bookingServices).getApproveBooking(date);
  return data;
});

