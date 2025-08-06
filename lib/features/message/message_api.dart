import '/network/endpoint.dart';

final class MessageApi extends Endpoint {
  MessageApi.getAll() : super('/c/bf17-9de2-439b-bea6', ReqMethod.get);
  MessageApi.delete(String key) : super('/c/bf17-9de2-439b-bea6', ReqMethod.get);
  // MessageApi.user() : super('/c/cf07-15da-4367-a9eb', ReqMethod.get);
}
