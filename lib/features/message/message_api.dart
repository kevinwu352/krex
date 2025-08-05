import '/network/endpoint.dart';

final class MessageApi extends Endpoint {
  MessageApi.messageList(int count) : super('/c/bf17-9de2-439b-bea6', ReqMethod.get);
}
