import '../impl/annotation.dart' as annotation;

/// This field might be null.
const Object optional = annotation.optional;

/// Instances are created by the [ViberBot].
const Object incoming = annotation.incoming;

/// Instances are sent by the [ViberBot].
const Object outgoing = annotation.outgoing;

/// Instances can be processed by the [ViberBot].
const Object command = annotation.command;
