import 'package:equatable/equatable.dart';

abstract class BiyorEvents extends Equatable {
  const BiyorEvents();
  @override
  List<Object> get props => [];
}

class UserFetched extends BiyorEvents {} // Event to trigger API call