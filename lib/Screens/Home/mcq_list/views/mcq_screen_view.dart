import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memotask/Firestore/firestore_collections_and_documents.dart';
import 'package:memotask/Models/mcqModel.dart';
import 'package:memotask/Screens/Authentication/login/view_models/login_view_model.dart';
import 'package:memotask/Screens/Home/mcq_list/view_models/mcq_screen_view_model.dart';
import 'package:memotask/Screens/Home/mcq_list/views/question_number_header_view.dart';
import 'package:memotask/Utils/app_size.dart';
import 'package:memotask/Utils/const_colors.dart';
import 'package:memotask/main.dart';
import 'package:page_flip_builder/page_flip_builder.dart';
import 'package:provider/provider.dart';

class MCQScreen extends StatefulWidget {
  MCQScreen({
    super.key,
    required this.viewModel,
    required this.loginViewModel,
  });
  MCQViewModel viewModel;
  LoginViewModel loginViewModel;
  @override
  State<MCQScreen> createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.viewModel.initializeQuestions();
  }

  final flipKey = GlobalKey<PageFlipBuilderState>();

  Future<void> onFlip(bool isFront, BuildContext context) async {
    // if (isFront) {
    //   widget.viewModel.setCurrentQuestionIndex(
    //     widget.viewModel.currentQuestionIndex + 1,
    //   );
    // }

    if (!isFront) {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      await FirestoreRefrence.postQuestion(uid,
          widget.viewModel.questions[widget.viewModel.currentQuestionIndex]);
      await FirestoreRefrence.streakIncrement(
        uid,
        widget.loginViewModel.loggedInUser!.streak!,
      );
      await Future.delayed(const Duration(seconds: 1)).then((value) {
        if (widget.viewModel.currentQuestionIndex ==
            widget.viewModel.questions.length - 1) {
          widget.viewModel.clearQuestions();
          widget.viewModel.fetchNewQuestions();
          flipKey.currentState!.flip();
          return;
        }
        widget.viewModel.questions[widget.viewModel.currentQuestionIndex]
            .selectedAnswer = '';
        widget.viewModel.setCurrentQuestionIndex(
          widget.viewModel.currentQuestionIndex + 1,
        );
        flipKey.currentState!.flip();
      });
    }

    // Shuffling the options
    widget.viewModel.questions[widget.viewModel.currentQuestionIndex].options
        .shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.viewModel.questions.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: AppSizes.spacingSmall),

                  // Question Numbers
                  QuestionNumbers(widget: widget),

                  // Question Care view

                  PageFlipBuilder(
                    key: flipKey,
                    frontBuilder: (BuildContext context) => cardFront(context),
                    backBuilder: (BuildContext context) => cardBack(context),
                    onFlipComplete: (p0) async {
                      await onFlip(
                        p0,
                        context,
                      );
                    },
                    flipAxis: Axis.horizontal,
                    interactiveFlipEnabled: false,
                    maxTilt: 0.003,
                  ),

                  SizedBox(height: AppSizes.getDeviceHeight(context) * 0.02),

                  // Next and Previous Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      previewBtn(context),
                      nextBtn(context),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  ElevatedButton nextBtn(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadius,
          ),
        ),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        minimumSize: Size(
          AppSizes.buttonWidthMedium,
          AppSizes.buttonHeight,
        ),
        maximumSize: Size(
          AppSizes.buttonWidthMedium,
          AppSizes.buttonHeightMedium,
        ),
      ),
      onPressed: () {
        if (widget.viewModel.currentQuestionIndex ==
            widget.viewModel.questions.length - 1) {
          widget.viewModel.clearQuestions();
          widget.viewModel.fetchNewQuestions();
          return;
        }
        widget.viewModel.setCurrentQuestionIndex(
          widget.viewModel.currentQuestionIndex + 1,
        );
      },
      child: Text(
        widget.viewModel.currentQuestionIndex ==
                widget.viewModel.questions.length - 1
            ? 'Generate More'
            : 'Next',
      ),
    );
  }

  ElevatedButton previewBtn(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadius,
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        minimumSize: Size(
          AppSizes.buttonWidthMedium,
          AppSizes.buttonHeight,
        ),
        maximumSize: Size(
          AppSizes.buttonWidthMedium,
          AppSizes.buttonHeightMedium,
        ),
      ),
      onPressed: () {
        if (widget.viewModel.currentQuestionIndex == 0) {
          return;
        }
        widget.viewModel.setCurrentQuestionIndex(
          widget.viewModel.currentQuestionIndex - 1,
        );
      },
      child: const Text('Previous'),
    );
  }

  Widget cardFront(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding,
        vertical: AppSizes.spacingSmall,
      ),
      width: AppSizes.getDeviceWidth(context),
      height: AppSizes.getDeviceHeight(context) * 0.56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadiusSmall,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: AppSizes.shadowBlurRadiusSmall,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: AppSizes.spacingMedium,
          ),
          // Question Numbering
          Text(
            "Question ${widget.viewModel.currentQuestionIndex + 1} of ${widget.viewModel.questions.length}",
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  fontWeight: FontWeight.w500,
                  fontSize: AppSizes.fontSize,
                ),
          ),
          const Spacer(),
          // Question
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spacingSmall, vertical: 5),
            child: Text(
              widget.viewModel.questions[widget.viewModel.currentQuestionIndex]
                  .question,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: AppSizes.getDeviceWidth(context) * 0.05),
            ),
          ),
          const Spacer(),
          // Options
          ...questionOptions(context),

          const SizedBox(
            height: AppSizes.spacingMedium,
          ),
        ],
      ),
    );
  }

  List<Widget> questionOptions(BuildContext context) {
    // Shuffle the options

    return List.generate(
      widget.viewModel.questions[widget.viewModel.currentQuestionIndex].options
          .length,
      (index) => GestureDetector(
        onTap: () {
          setState(() {
            widget.viewModel.questions[widget.viewModel.currentQuestionIndex]
                    .selectedAnswer =
                widget
                    .viewModel
                    .questions[widget.viewModel.currentQuestionIndex]
                    .options[index];
            bool isCorrect = widget
                    .viewModel
                    .questions[widget.viewModel.currentQuestionIndex]
                    .selectedAnswer ==
                widget.viewModel
                    .questions[widget.viewModel.currentQuestionIndex].answer;
            widget.viewModel.questions[widget.viewModel.currentQuestionIndex]
                    .status =
                isCorrect
                    ? QuestionStatus.answeredCorrect
                    : QuestionStatus.answeredWrong;

            flipKey.currentState!.flip();
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: 6,
          ),
          height: AppSizes.getDeviceHeight(context) * 0.07,
          width: AppSizes.getDeviceWidth(context),
          decoration: BoxDecoration(
            color: widget
                        .viewModel
                        .questions[widget.viewModel.currentQuestionIndex]
                        .selectedAnswer ==
                    widget
                        .viewModel
                        .questions[widget.viewModel.currentQuestionIndex]
                        .options[index]
                ? Theme.of(context).colorScheme.tertiaryContainer
                : Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(
              AppSizes.borderRadiusSmall,
            ),
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiaryContainer,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding,
              vertical: AppSizes.getDeviceHeight(context) * 0.01,
            ),
            child: Center(
              child: Text(
                widget
                    .viewModel
                    .questions[widget.viewModel.currentQuestionIndex]
                    .options[index],
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardBack(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding,
        vertical: AppSizes.spacingSmall,
      ),
      width: AppSizes.getDeviceWidth(context),
      height: AppSizes.getDeviceHeight(context) * 0.56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadiusSmall,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            blurRadius: AppSizes.shadowBlurRadiusSmall,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: AppSizes.spacingMedium,
          ),
          if (widget.viewModel.questions[widget.viewModel.currentQuestionIndex]
                  .answer ==
              widget.viewModel.questions[widget.viewModel.currentQuestionIndex]
                  .selectedAnswer)
            Icon(
              Iconsax.tick_circle,
              size: AppSizes.getIdealWidth(100, context),
              color: Theme.of(context).colorScheme.primary,
            )
          else
            Icon(
              Iconsax.close_circle,
              size: AppSizes.getIdealWidth(100, context),
              color: Theme.of(context).colorScheme.error,
            ),
          const SizedBox(
            height: AppSizes.spacingMedium,
          ),
          Text(
            "Correct Answer : ${widget.viewModel.questions[widget.viewModel.currentQuestionIndex].answer}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(
            height: AppSizes.spacingMedium,
          ),
          Text(
            "Your Answer : ${widget.viewModel.questions[widget.viewModel.currentQuestionIndex].selectedAnswer}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(
            height: AppSizes.spacingMedium,
          ),
          Text(
            "Moving to next question in 1 second...",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.getDeviceWidth(context) * 0.04,
                ),
          )
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     primary: Theme.of(context).colorScheme.primary,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(
          //         AppSizes.borderRadius,
          //       ),
          //     ),
          //     foregroundColor: Theme.of(context).colorScheme.onPrimary,
          //     minimumSize: const Size(
          //       AppSizes.buttonWidthMedium,
          //       AppSizes.buttonHeightMedium,
          //     ),
          //     maximumSize: const Size(
          //       AppSizes.buttonWidthMedium,
          //       AppSizes.buttonHeightMedium,
          //     ),
          //   ),
          //   onPressed: () {
          //     if (widget.viewModel.currentQuestionIndex ==
          //         widget.viewModel.questions.length - 1) {
          //       return;
          //     }
          //     widget.viewModel.setCurrentQuestionIndex(
          //       widget.viewModel.currentQuestionIndex + 1,
          //     );
          //     flipKey.currentState!.flip();
          //   },
          //   child: const Text('Next'),
          // ),
        ],
      ),
    );
  }
}
