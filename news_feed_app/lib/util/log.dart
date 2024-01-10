String log(tag, String message, {bool suppressed = false}) {
  String header = '';
  if (tag is String) {
    header = tag;
  } else {
    header = tag.runtimeType.toString();
  }
  final statement = '[$header] -> $message';

  // ignore: avoid_print
  if (!suppressed) print(statement);
  return statement;
}
