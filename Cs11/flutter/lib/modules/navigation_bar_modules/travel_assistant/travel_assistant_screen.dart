import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/core/colors.dart';
import 'package:kemet/core/navigation.dart';
import 'package:kemet/core/strings.dart';
import 'package:kemet/models/chat_model.dart';
import 'package:kemet/modules/navigation_bar/home_screen_and_navigation_bar.dart';
import 'package:kemet/modules/navigation_bar_modules/travel_assistant/travel_assistant_cubit.dart';
import 'package:kemet/modules/navigation_bar_modules/travel_assistant/widgets.dart';

//TODO: create the screen.
class TravelAssistantView extends StatefulWidget {
  const TravelAssistantView({super.key});

  @override
  State<TravelAssistantView> createState() => _TravelAssistantViewState();
}

class _TravelAssistantViewState extends State<TravelAssistantView> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TravelAssistantCubit(),
      child: BlocConsumer<TravelAssistantCubit, TravelAssistantState>(
        listener: (context, state) {},
        builder: (context, state) {
          var myCubit = BlocProvider.of<TravelAssistantCubit>(context);

          return Scaffold(
            appBar: chatAppBar(context),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    controller: myCubit.controller,
                    itemBuilder: (context, item) {
                      if (myCubit.messages[item].messageType == 'receiver') {
                        return messageReceiver(
                            myCubit.messages[item].messageContent);
                      }
                      if (myCubit.messages[item].messageType == 'sender') {
                        return messageSender(
                            myCubit.messages[item].messageContent);
                      }
                    },
                    itemCount: myCubit.messages.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.grey, width: 2)),
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 75,
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            maxLines: 3,
                            controller: myCubit.chatController,
                            decoration: const InputDecoration(
                                hintText: "Type Something",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is !GetMessageFromAILoading,
                          fallback: (context)=> const Center(
                            child:SizedBox(),
                          ),
                          builder:(context)=> FloatingActionButton(
                            onPressed: () {
                              // myCubit.completeWithSSE();
                              myCubit.addMessageInChat(
                                  myCubit.chatController.text.trim(), 'receiver');
                            },
                            backgroundColor: Colors.black,
                            elevation: 0,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
