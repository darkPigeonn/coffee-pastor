import 'package:flutter_coffee_application/resource/model/comment_model.dart';
import 'package:flutter_coffee_application/resource/services/api/comment_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentServices =
    Provider<CommentServices>((ref) => CommentServices());

final commentProvider =
    FutureProvider.family<List<ModelComment>, String>((ref, promoId) async {
  var data = await ref.read(commentServices).getCommentPromo(promoId);
  return data;
});
