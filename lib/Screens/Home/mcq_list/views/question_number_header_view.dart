import 'package:flutter/material.dart';
import 'package:memotask/Screens/Home/mcq_list/views/mcq_screen_view.dart';
import 'package:memotask/Utils/app_size.dart';

class QuestionNumbers extends StatelessWidget {
  const QuestionNumbers({
    super.key,
    required this.widget,
  });

  final MCQScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Question Numbers 1-5
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(
              widget.viewModel.questions.length ~/ 2,
              (index) => GestureDetector(
                onTap: () {
                  // log(index.toString());
                  // widget.viewModel.setCurrentQuestionIndex(index);
                },
                child: Container(
                  width: AppSizes.getIdealWidth(32, context),
                  height: AppSizes.getIdealWidth(32, context),
                  decoration: BoxDecoration(
                    color: widget.viewModel.currentQuestionIndex == index
                        ? Theme.of(context).colorScheme.tertiaryContainer
                        : Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusSmall,
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizes.getDeviceHeight(context) * 0.01),
        // Question Numbers 6-10
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...List.generate(
              widget.viewModel.questions.length ~/ 2,
              (index) => GestureDetector(
                onTap: () {
                  // log((index + (widget.viewModel.questions.length ~/ 2))
                  //     .toString());

                  // widget.viewModel.setCurrentQuestionIndex(
                  //     index + (widget.viewModel.questions.length ~/ 2));
                },
                child: Container(
                  width: AppSizes.getIdealWidth(32, context),
                  height: AppSizes.getIdealWidth(32, context),
                  decoration: BoxDecoration(
                    color: widget.viewModel.currentQuestionIndex ==
                            (index + (widget.viewModel.questions.length ~/ 2))
                        ? Theme.of(context).colorScheme.tertiaryContainer
                        : Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusSmall,
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (index + 1 + (widget.viewModel.questions.length ~/ 2))
                          .toString(),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
            ),

            // Question Card
          ],
        ),
        SizedBox(height: AppSizes.getDeviceHeight(context) * 0.01),
      ],
    );
  }
}
