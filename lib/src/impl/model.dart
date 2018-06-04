part of '../api/model.dart';

class _SetWebhook extends _Command<BaseResponse> implements SetWebhook {
  final String url;
  final bool sendName;
  final bool sendPhoto;
  final List<String> eventTypes;

  static const List<String> allowedEventTypes = const [
    'delivered',
    'seen',
    'failed',
    'subscribed',
    'unsubscribed',
    'conversation_started'
  ];

  _SetWebhook(
    this.url, {
    Iterable<String> eventTypes,
    this.sendName,
    this.sendPhoto,
  })
      : this.eventTypes = copyListAllowed(eventTypes, allowedEventTypes),
        super._('set_webhook', _BaseResponse.fromMap);

  @override
  Map<String, Object> get data => noNull({
        'url': url,
        'event_types': eventTypes,
        'send_photo': sendPhoto,
        'send_name': sendName,
      });
}

class _DeleteWebhook extends _Command<BaseResponse> implements DeleteWebhook {
  _DeleteWebhook() : super._('set_webhook', _BaseResponse.fromMap);

  @override
  Map<String, Object> get data => noNull({'url': ''});
}

class _GetAccountInfo extends _Command<AccountResponse>
    implements GetAccountInfo {
  _GetAccountInfo() : super._('get_account_info', _AccountResponse.fromMap);

  @override
  Map<String, Object> get data => {};
}

class _SendMessage extends _Command<BaseResponse> implements SendMessage {
  final String receiver;
  final String type;
  final Sender sender;
  final String trackingData;
  final int minApiVersion;
  final String text;
  final String media;

  _SendMessage(
    this.receiver,
    this.type,
    Sender sender, {
    this.trackingData,
    this.minApiVersion = 1,
    this.text,
    this.media,
  })
      : this.sender = sender as _Sender,
        super._('send_message', _BaseResponse.fromMap);

  @override
  Map<String, Object> get data => noNull({
        'receiver': receiver,
        'type': type,
        'sender': Serializable.toMapOrNull(sender),
        'tracking_data': trackingData,
        'min_api_version': minApiVersion,
        'text': text,
        'media': media,
      });
}

class _PostToPublicChat extends _Command<BaseResponse>
    implements PostToPublicChat {
  final String from;
  final String type;
  final Sender sender;
  final String text;

  _PostToPublicChat(
    this.from,
    this.type, {
    Sender sender,
    this.text,
  })
      : this.sender = sender as _Sender,
        super._('post', _BaseResponse.fromMap);

  @override
  Map<String, Object> get data => noNull({
        'from': from,
        'type': type,
        'sender': Serializable.toMapOrNull(sender),
        'text': text,
      });
}

class _AccountResponse extends Serializable implements AccountResponse {
  final int status;
  final String statusMessage;
  final String id;
  final String name;
  final String uri;
  final String icon;
  final String background;
  final String category;
  final String subcategory;
  final _Location location;
  final String country;
  final String webhook;
  final List<String> eventTypes;
  final int subscribersCount;
  final List<_User> members;

  _AccountResponse(
    this.status,
    this.statusMessage,
    this.id,
    this.name,
    this.uri,
    this.icon,
    this.background,
    this.category,
    this.subcategory,
    Location location,
    this.country,
    this.webhook,
    Iterable<String> eventTypes,
    this.subscribersCount,
    Iterable<User> members,
  )
      : this.location = location as _Location,
        this.members = copyList(mapOrNull(members, (e) => e as _User)),
        this.eventTypes = copyList(mapOrNull(eventTypes, (e) => e as String));

  static _AccountResponse fromMap(Map<String, Object> map) => map == null
      ? null
      : new _AccountResponse(
          map['status'],
          map['status_message'],
          map['id'],
          map['name'],
          map['uri'],
          map['icon'],
          map['background'],
          map['category'],
          map['subcategory'],
          _Location.fromMap(map['location']),
          map['country'],
          map['webhook'],
          map['event_types'],
          map['subscribers_count'],
          mapOrNull(map['members'], _User.fromMap),
        );

  @override
  Map<String, Object> createMap() => noNull({
        'status': status,
        'status_message': statusMessage,
        'id': id,
        'name': name,
        'uri': uri,
        'icon': icon,
        'background': background,
        'category': category,
        'subcategory': subcategory,
        'location': location?.toMap(),
        'country': country,
        'webhook': webhook,
        'event_types': eventTypes,
        'subscribers_count': subscribersCount,
        'members': ls(members),
      });
}

class _BaseResponse extends Serializable implements BaseResponse {
  final int status;
  final String statusMessage;

  _BaseResponse(
    this.status,
    this.statusMessage,
  );

  static _BaseResponse fromMap(Map<String, Object> map) => map == null
      ? null
      : new _BaseResponse(
          map['status'],
          map['status_message'],
        );

  @override
  Map<String, Object> createMap() => noNull({
        'status': status,
        'status_message': statusMessage,
      });
}

class _CallbackRequest extends Serializable implements CallbackRequest {
  final String event;
  final int messageToken;
  final int timestamp;
  final String userId;
  final String desc;
  final _User sender;
  final _User user;
  final _Message message;

  _CallbackRequest(
    this.event,
    this.messageToken,
    this.timestamp, {
    this.userId,
    this.desc,
    User sender,
    User user,
    Message message,
  })
      : this.sender = sender as _User,
        this.user = user as _User,
        this.message = message as _Message;

  static _CallbackRequest fromMap(Map<String, Object> map) => map == null
      ? null
      : new _CallbackRequest(
          map['event'], map['message_token'], map['timestamp'],
          userId: map['user_id'],
          desc: map['desc'],
          sender: _User.fromMap(map['sender']),
          user: _User.fromMap(map['user']),
          message: _Message.fromMap(map['message']));

  @override
  Map<String, Object> createMap() => noNull({
        'event': event,
        'message_token': messageToken,
        'timestamp': timestamp,
        'user_id': userId,
        'desc': desc,
        'sender': sender?.toMap(),
        'user': user?.toMap(),
        'message': message?.toMap(),
      });
}

class _Location extends Serializable implements Location {
  final double lon;
  final double lat;

  _Location(
    this.lon,
    this.lat,
  );

  static _Location fromMap(Map<String, Object> map) => map == null
      ? null
      : new _Location(
          map['lon'],
          map['lat'],
        );

  @override
  Map<String, Object> createMap() => noNull({
        'lon': lon,
        'lat': lat,
      });
}

class _Contact extends Serializable implements Contact {
  final String name;
  final String phoneNumber;

  _Contact(
    this.name,
    this.phoneNumber,
  );

  static _Contact fromMap(Map<String, Object> map) => map == null
      ? null
      : new _Contact(
          map['name'],
          map['phone_number'],
        );

  @override
  Map<String, Object> createMap() => noNull({
        'name': name,
        'phone_number': phoneNumber,
      });
}

class _Message extends Serializable implements Message {
  final String type;
  final String text;
  final String media;
  final _Location location;
  final _Contact contact;
  final String trackingData;
  final String fileName;
  final int fileSize;
  final int duration;
  final int stickerId;

  _Message(
    this.type, {
    this.text,
    this.media,
    Location location,
    Contact contact,
    this.trackingData,
    this.fileName,
    this.fileSize,
    this.duration,
    this.stickerId,
  })
      : this.location = location as _Location,
        this.contact = contact as _Contact;

  static _Message fromMap(Map<String, Object> map) => map == null
      ? null
      : new _Message(
          map['type'],
          text: map['text'],
          media: map['media'],
          location: _Location.fromMap(map['location']),
          contact: _Contact.fromMap(map['contact']),
          trackingData: map['tracking_data'],
          fileName: map['file_name'],
          fileSize: map['file_size'],
          duration: map['duration'],
          stickerId: map['sticker_id'],
        );

  @override
  Map<String, Object> createMap() => noNull({
        'type': type,
        'text': text,
        'media': media,
        'location': location?.toMap(),
        'contact': contact?.toMap(),
        'tracking_data': trackingData,
        'file_name': text,
        'file_size': text,
        'duration': duration,
        'sticker_id': stickerId,
      });
}

class _Sender extends Serializable implements Sender {
  final String name;
  final String avatar;

  _Sender(
    this.name, {
    this.avatar,
  });

  static _Sender fromMap(Map<String, Object> map) => map == null
      ? null
      : new _Sender(
          map['name'],
          avatar: map['avatar'],
        );

  @override
  Map<String, Object> createMap() => noNull({
        'name': name,
        'avatar': avatar,
      });
}

class _User extends Serializable implements User {
  final String id;
  final String name;
  final String avatar;
  final String country;
  final String language;
  final String primaryDeviceOs;
  final int apiVersion;
  final String viberVersion;
  final int mcc;
  final int mnc;
  final String deviceType;
  final String role;

  _User(
    this.id,
    this.name,
    this.avatar, {
    this.country,
    this.language,
    this.primaryDeviceOs,
    this.apiVersion,
    this.viberVersion,
    this.mcc,
    this.mnc,
    this.deviceType,
    this.role,
  });

  static _User fromMap(Map<String, Object> map) => map == null
      ? null
      : new _User(
          map['id'],
          map['name'],
          map['avatar'],
          country: map['country'],
          language: map['language'],
          primaryDeviceOs: map['primary_device_os'],
          apiVersion: map['api_version'],
          viberVersion: map['viber_version'],
          mcc: map['mcc'],
          mnc: map['mnc'],
          deviceType: map['device_type'],
          role: map['role'],
        );

  @override
  Map<String, Object> createMap() => noNull({
        'id': id,
        'name': name,
        'avatar': avatar,
        'country': country,
        'language': language,
        'primary_device_os': primaryDeviceOs,
        'api_version': apiVersion,
        'viber_version': viberVersion,
        'mcc': mcc,
        'mnc': mnc,
        'device_type': deviceType,
        'role': role,
      });
}

typedef T _Converter<T>(dynamic result);

final _Converter<bool> _boolean = (b) => b as bool;

abstract class _Command<T> extends Serializable implements Command<T> {
  final String method;
  final _Converter<T> converter;

  _Command._(this.method, this.converter);

  Map<String, Object> get data;

  Map<String, Object> createMap() => {'method': method, 'data': data};

  T convert(Object result) {
    return converter(result);
  }
}
