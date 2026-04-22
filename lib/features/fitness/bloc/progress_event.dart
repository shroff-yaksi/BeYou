part of 'progress_bloc.dart';

@immutable
sealed class ProgressEvent {}

class LoadProgressEvent extends ProgressEvent {}
