part of 'prediction_cubit.dart';



abstract class PredictionState {}

class PredictionInitial extends PredictionState {}

class PredictionLoading extends PredictionState {}

class PredictionSuccess extends PredictionState {
  final PredictionModel prediction;
  PredictionSuccess(this.prediction);
}

class PredictionError extends PredictionState {
  final String message;
  PredictionError(this.message);
}

class PredictionHistoryLoading extends PredictionState {}

class PredictionHistoryLoaded extends PredictionState {
  final List<SavedPrediction> predictions;
  PredictionHistoryLoaded(this.predictions);
}
