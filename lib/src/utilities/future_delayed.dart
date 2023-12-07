Future<void> wait({int seconds = 10}) async =>
    Future<void>.delayed(Duration(seconds: seconds));
