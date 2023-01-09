import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<Event> debounce<Event>({
  Duration duration = const Duration(microseconds: 500),
}) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}
