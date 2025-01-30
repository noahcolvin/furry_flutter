import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final options = BaseOptions(
    baseUrl: 'http://10.0.2.2:54321/functions/v1',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 30),
  );
  return Dio(options);
}
