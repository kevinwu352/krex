import '/network/network.dart';

final class MessageApi extends Endpoint {
  MessageApi.getAll() : super('/c/b1c2-0915-4a17-83c2', ReqMethod.get);
  MessageApi.delete(int id) : super('/c/xxx', ReqMethod.get);
}
