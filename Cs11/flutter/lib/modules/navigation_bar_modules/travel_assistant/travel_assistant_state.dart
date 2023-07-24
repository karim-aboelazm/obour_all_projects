part of './travel_assistant_cubit.dart';

@immutable
abstract class TravelAssistantState {}

class TravelAssistantInitial extends TravelAssistantState {}

class AddMyMessageToMessages extends TravelAssistantState {}

class SendMessageSuccess extends TravelAssistantState {}
class SendMessageLoading extends TravelAssistantState {}
class SendMessageError extends TravelAssistantState {}


class AddMessageToListLoading extends TravelAssistantState {}
class AddMessageToListSuccess extends TravelAssistantState {}

class GetMessageFromAILoading extends TravelAssistantState {}
class GetMessageFromAISuccess extends TravelAssistantState {}
class GetMessageFromAIError extends TravelAssistantState {}
