part of 'go_routes.dart';

class StreamAuthScope extends InheritedNotifier<StreamAuthNotifier> {
  const StreamAuthScope({super.key, required super.child, required this.customNotifier})
      : super(
    notifier: customNotifier,
  );

  final StreamAuthNotifier customNotifier;
}


class StreamAuthNotifier extends ChangeNotifier {
  StreamAuthNotifier({this.appState});

  void notify({String? message, required AppState state}) {
    appState = state;
    log('-' * 60);
    log('|');
    log('|  StreamAuthNotifier: {hasListeners: ${hasListeners.toString()}, message: $message}}');
    log('|');
    log('-' * 60);
    notifyListeners();
  }

  AppState? appState;

  static AppState? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StreamAuthScope>()!
        .customNotifier!
        .appState;
  }
}