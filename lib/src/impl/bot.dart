part of '../api/bot.dart';

class _ViberBot implements ViberBot {
  final String token;

  int count = 0;
  _ViberBot(this.token);

  @override
  Future<T> sendCommand<T>(Command<T> command) => _process(count++, command);

  Future<T> _process<T>(int id, Command<T> command) async {
//    print("sending  #$id: $command");
    var result = await postToViber(
        token, command.method, (command as Serializable).toMap()['data']);
//    print('received #$id: ${json2string(result)}');
    // TODO: handle error responses
    return command.convert(result);
  }
}
