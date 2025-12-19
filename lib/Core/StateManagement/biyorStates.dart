// lib/bloc/user_state.dart
import 'package:equatable/equatable.dart';

abstract class BiyorStates extends Equatable {
  const BiyorStates();
  @override
  List<Object> get props => [];
}

class GameRulesInitial extends BiyorStates {}

class GameRulesLoading extends BiyorStates {}

class GameRulesLoaded extends BiyorStates {
  final List<dynamic> rules;

  GameRulesLoaded(this.rules);
}

class GameRulesError extends BiyorStates {
  final String message;
  GameRulesError(this.message);
}
