import '/network/endpoint.dart';

final class HomeApi extends Endpoint {
  HomeApi.slideshowList(int count)
    : super('/c/08c8-ac33-4baa-b6ef', ReqMethod.get, parameters: {'count': count}, headers: {'kk': 'abc'});
}
