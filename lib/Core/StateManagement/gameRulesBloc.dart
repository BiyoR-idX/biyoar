import 'package:biyoar/Core/Services/apiService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'biyorEvents.dart';
import 'biyorStates.dart';

class GameRulesBloc extends Bloc<BiyorEvents, BiyorStates> {
  final ApiClient apiService;

  GameRulesBloc(this.apiService) : super(GameRulesInitial()) {
    on<FetchGameRules>((event, emit) async {
      emit(GameRulesLoading());

      try {
        final data = await apiService.fetchRules(
          biyoLength: event.biyoLength,
          dandiLength: event.dandiLength,
          fieldLength: event.fieldLength,
          fieldWidth: event.fieldWidth,
          surfaceType: event.surfaceType,
          players: event.players,
        );

        emit(GameRulesLoaded(data["rules_cards"]));
      } catch (e) {
        emit(GameRulesError(e.toString()));
      }
    });
  }
}
