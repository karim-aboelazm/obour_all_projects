import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:kemet/core/constants.dart';
import 'package:kemet/helper/end_points.dart';
import 'package:kemet/helper/remote/dio_helper.dart';
import 'package:kemet/models/chat_model.dart';
import 'package:kemet/models/message_from_ai.dart';

part './travel_assistant_state.dart';

class TravelAssistantCubit extends Cubit<TravelAssistantState> {
  TravelAssistantCubit() : super(TravelAssistantInitial());

  //var openAI;

  // MessageAi? messageFromAI;
  StreamSubscription? subscription;

  TextEditingController chatController = TextEditingController();
  final ScrollController controller = ScrollController();

  List<ChatMessageModel> messages = [
    // TODO : make the name dynamic
    ChatMessageModel(
        messageContent: 'Hi Abanob Ashraf', messageType: 'sender'),
    ChatMessageModel(
        messageContent: 'I’m TATA your Travel Assistant Bot',
        messageType: 'sender'),
    ChatMessageModel(
        messageContent: 'I will recommend the Right Trip for you?',
        messageType: 'sender'),

  ];

  void addMessageInChat(messageContent, messageType) {
    emit(AddMessageToListLoading());
    if (chatController.text != null) {
      if (messageType == 'receiver') {
        messages.add(ChatMessageModel(
            messageContent: messageContent, messageType: messageType));
        var msg = chatController.text.trim();
        chatController.clear();
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        messages.add(ChatMessageModel(messageContent: '...', messageType: 'sender'));
        emit(AddMessageToListSuccess());
        getAIMessage(question: msg);
      }
    }
  }

  MessageAi? messageAi;
  void getAIMessage({required question}) async {
    emit(GetMessageFromAILoading());
    Dio? dio = Dio();

    // dio!.options.headers["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNGFjMzM4ZjUtZjliOS00N2I4LWE5ZDctMGU2OTZkNWYzODIxIiwidHlwZSI6ImFwaV90b2tlbiJ9.nFhECRCTZAW-RXhS2diiCLIpyTfIayEXjtiRkU3sxKs}';
    // dio.options.headers["Content-Type"] = 'application/json';
    await dio.post(
      'https://api.edenai.run/v2/text/chat',
      data: {
        'providers': 'openai',
        'text': question.toString(),
      },
      options:Options(
        contentType: 'application/json',
        receiveDataWhenStatusError: true,
        headers: {
          'Authorization':'Bearer ${AppConstants.aiToken}'
        }
      ),
    ).then((value) {
      // print('Success');
      // print();
      messages.removeLast();
      messages.add(ChatMessageModel(messageContent: value.data['openai']['generated_text'], messageType: 'sender'));
      emit(GetMessageFromAISuccess());


    }).catchError((err) {
      // print('Error');
      print(err.toString());

      emit(GetMessageFromAIError());
    });
  }
}
