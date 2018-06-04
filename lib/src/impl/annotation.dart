const Object optional = const _Optional();
const Object incoming = const _Category('incoming');
const Object outgoing = const _Category('outgoing');
const Object command = const _Category('command');

class _Optional {
  const _Optional();
}

class _Category {
  final String type;
  const _Category(this.type);

  @override
  String toString() => type;

  @override
  int get hashCode => type.hashCode;

  @override
  bool operator ==(dynamic other) =>
      (other is _Category) && type == (other as _Category).type;
}
