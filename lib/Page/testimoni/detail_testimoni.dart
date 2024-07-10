import 'package:flutter/material.dart';
import 'package:flutter_coffee_application/component/Testimoni/testimoni.dart';
import 'package:flutter_coffee_application/resource/provider/testimoni_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailTestimoni extends ConsumerStatefulWidget {
  final String tetimoniId;
  const DetailTestimoni({super.key, required this.tetimoniId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailTestimoniState();
}

class _DetailTestimoniState extends ConsumerState<DetailTestimoni> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Testimoni"),),
      body: ref.watch(detailTestimoniProvider(widget.tetimoniId)).when(
            data: (data) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: DetailTestimoniIcon(testimoni: data),
              );
            },
            error: (error, s) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
