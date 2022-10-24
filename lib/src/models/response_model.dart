class ServerResponse{
  Object data;
  String msg;
  bool  success;

  ServerResponse({
    required this.data,
    required this.success,
    required this.msg});
}