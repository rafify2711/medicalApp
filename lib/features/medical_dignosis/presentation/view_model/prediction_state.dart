part of 'prediction_cubit.dart';



abstract class PredictionState {}

class PredictionInitial extends PredictionState {}

class PredictionLoading extends PredictionState {}

class PredictionSuccess extends PredictionState {
  final PredictionModel prediction;
  PredictionSuccess(this.prediction);
}

class PredictionFailure extends PredictionState {
  final String error;
  PredictionFailure(this.error);
}
