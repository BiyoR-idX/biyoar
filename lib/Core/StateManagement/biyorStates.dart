// lib/bloc/user_state.dart
import 'package:equatable/equatable.dart';

abstract class BiyorStates extends Equatable {
  const BiyorStates();
  @override
  List<Object> get props => [];
}

class UserInitial extends BiyorStates {}

class UserLoadInProgress extends BiyorStates {} // Loading state

class UserLoadSuccess extends BiyorStates {
  final List<dynamic> users; // Replace dynamic with your actual User model
  const UserLoadSuccess({required this.users});
  @override
  List<Object> get props => [users];
}

class UserLoadFailure extends BiyorStates {
  final String error;
  const UserLoadFailure({required this.error});
  @override
  List<Object> get props => [error];
}
