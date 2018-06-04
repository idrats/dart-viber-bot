import 'annotation.dart';
import '../impl/util.dart';

part '../impl/model.dart';

/// See the [Viber Bot API documentation on **setWebhook**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api/#setting-a-webhook
@command
abstract class SetWebhook implements Command<BaseResponse> {
  String get url;
  @optional
  List<String> get eventTypes;
  @optional
  bool get sendName;
  @optional
  bool get sendPhoto;

  SetWebhook._();

  factory SetWebhook(
    String url, {
    Iterable<String> eventTypes,
    bool sendName,
    bool sendPhoto,
  }) = _SetWebhook;
}

/// See the [Viber Bot API documentation on **deleteWebhook**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api/#removing-your-webhook
@command
abstract class DeleteWebhook implements Command<BaseResponse> {
  DeleteWebhook._();

  factory DeleteWebhook() = _DeleteWebhook;
}

/// See the [Viber Bot API documentation on **getAccountInfo**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api/#get-account-info
@command
abstract class GetAccountInfo implements Command<AccountResponse> {
  GetAccountInfo._();

  factory GetAccountInfo() = _GetAccountInfo;
}

/// See the [Viber Bot API documentation on **sendMessage**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api/#send-message
@command
abstract class SendMessage implements _Command<BaseResponse> {
  String get receiver;
  String get type;
  Sender get sender;
  @optional
  String get trackingData;
  @optional
  int get minApiVersion;
  @optional
  String get text;
  @optional
  String get media;

  SendMessage._();

  factory SendMessage.Text(
    String receiver,
    Sender sender,
    String text, {
    String trackingData,
    int minApiVersion,
  }) =>
      new _SendMessage(
        receiver,
        'text',
        sender,
        text: text,
        trackingData: trackingData,
        minApiVersion: minApiVersion,
      );

  factory SendMessage.Url(
    String receiver,
    Sender sender,
    String link, {
    String trackingData,
    int minApiVersion,
  }) =>
      new _SendMessage(
        receiver,
        'url',
        sender,
        media: link,
        trackingData: trackingData,
        minApiVersion: minApiVersion,
      );
// TODO: add other types of messages (picture, video, file, location,
// TODO: contact, sticker, carousel content)
}

/// See the [Viber Bot API documentation on **postToPublicChat**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api/#post-to-public-chat
@command
abstract class PostToPublicChat implements _Command<BaseResponse> {
  String get from;
  String get type;
  @optional
  Sender get sender;
  @optional
  String get text;

  PostToPublicChat._();

  factory PostToPublicChat.Text(
    String from,
    String text, {
    Sender sender,
  }) =>
      new _PostToPublicChat(
        from,
        'text',
        sender: sender,
        text: text,
      );
// TODO: add other types of messages (url)
}

/// See the [Viber Bot API documentation on **rest-bot-api**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api
@incoming
abstract class User {
  String get id;
  String get name;
  String get avatar;
  @optional
  String get country;
  @optional
  String get language;
  @optional
  String get primaryDeviceOs;
  @optional
  int get apiVersion;
  @optional
  String get viberVersion;
  @optional
  int get mcc;
  @optional
  int get mnc;
  @optional
  String get deviceType;
  @optional
  String get role;

  User._();

  factory User(
    String id,
    String name,
    String avatar, {
    String country,
    String language,
    String primaryDeviceOs,
    int apiVersion,
    String viberVersion,
    int mcc,
    int mnc,
    String deviceType,
    String role,
  }) = _User;
}

/// See the [Viber Bot API documentation on **rest-bot-api**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api
@incoming
abstract class AccountResponse {
  int get status;
  String get statusMessage;
  String get id;
  String get name;
  String get uri;
  String get icon;
  String get background;
  String get category;
  String get subcategory;
  Location get location;
  String get country;
  String get webhook;
  List<String> get eventTypes;
  int get subscribersCount;
  List<User> get members;

  AccountResponse._();

  factory AccountResponse(
    int status,
    String statusMessage,
    String id,
    String name,
    String uri,
    String icon,
    String background,
    String category,
    String subcategory,
    Location location,
    String country,
    String webhook,
    Iterable<String> eventTypes,
    int subscribersCount,
    Iterable<User> members,
  ) = _AccountResponse;
}

/// See the [Viber Bot API documentation on **rest-bot-api**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api
@incoming
abstract class BaseResponse {
  int get status;
  String get statusMessage;

  BaseResponse._();

  factory BaseResponse(
    int status,
    String statusMessage,
  ) = _BaseResponse;
}

/// See the [Viber Bot API documentation on **rest-bot-api**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api
@incoming
abstract class Contact {
  String get name;
  String get phoneNumber;

  Contact._();

  factory Contact(
    String name,
    String phoneNumber,
  ) = _Contact;
}

/// See the [Viber Bot API documentation on **rest-bot-api**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api
@incoming
abstract class Message {
  String get type;
  @optional
  String get text;
  @optional
  String get media;
  @optional
  Location get location;
  @optional
  Contact get contact;
  @optional
  String get trackingData;
  @optional
  String get fileName;
  @optional
  int get fileSize;
  @optional
  int get duration;
  @optional
  int get stickerId;

  Message._();

  factory Message(
    String type, {
    String text,
    String media,
    Location location,
    Contact contact,
    String trackingData,
    String fileName,
    int fileSize,
    int duration,
    int stickerId,
  }) = _Message;
}

/// See the [Viber Bot API documentation on **rest-bot-api**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api
@incoming
abstract class CallbackRequest {
  String get event;
  int get messageToken;
  int get timestamp;
  @optional
  String get userId;
  @optional
  String get desc;
  @optional
  User get sender;
  @optional
  User get user;
  @optional
  Message get message;

  CallbackRequest._();

  factory CallbackRequest.fromMap(Map<String, dynamic> map) =>
      _CallbackRequest.fromMap(map);

  factory CallbackRequest(String event, int messagetToken, int timestamp,
      {String userId,
      String desc,
      User sender,
      User user,
      Message message}) = _CallbackRequest;
}

/// See the [Viber Bot API documentation on **rest-bot-api**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api
@incoming
abstract class Location {
  double get lon;
  double get lat;

  Location._();

  factory Location(
    double lon,
    double lat,
  ) = _Location;
}

/// See the [Viber Bot API documentation on **rest-bot-api**][1].
///
/// [1]: https://developers.viber.com/docs/api/rest-bot-api
@outgoing
abstract class Sender {
  String get name;
  @optional
  String get avatar;

  Sender._();

  factory Sender(
    String name, {
    String avatar,
  }) = _Sender;
}

/// Commands can be sent bot the [ViberBot].
///
/// List of available commands:
/// * [SetWebhook]
/// * [DeleteWebhook]
/// * [SendMessage]
/// * [GetAccountInfo]
/// * [Post]
/// TODO: broadcast_message, get_user_details, get_online
///
abstract class Command<T> {
  String get method;

  Command._();

  T convert(Object result);
}
