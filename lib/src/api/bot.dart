library bot;

import 'dart:async';
import 'model.dart';
import '../impl/util.dart';

part '../impl/bot.dart';

/// This ViberBot talks to the [Viber Bot API][1].
///
/// You can instruct the ViberBot to send data to the Viber servers using
/// [sendCommand]/ See [Command] for the list of available commands.
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api
abstract class ViberBot {
  ViberBot._();

  factory ViberBot(String token) = _ViberBot;

  Future<T> sendCommand<T>(Command<T> command);
}
