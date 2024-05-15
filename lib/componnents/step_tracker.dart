import 'package:flutter/material.dart';

class HorizontalStepper extends StatefulWidget {
  const HorizontalStepper({super.key});

  @override
  HorizontalStepperState createState() => HorizontalStepperState();
}

class HorizontalStepperState extends State<HorizontalStepper> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          canvasColor: Colors.transparent,
          primarySwatch: MaterialColor(
            Theme.of(context).colorScheme.background.value,
            <int, Color>{
              50: Theme.of(context).colorScheme.background,
              100: Theme.of(context).colorScheme.background,
              200: Theme.of(context).colorScheme.background,
              300: Theme.of(context).colorScheme.background,
              400: Theme.of(context).colorScheme.background,
              500: Theme.of(context).colorScheme.background,
              600: Theme.of(context).colorScheme.background,
              700: Theme.of(context).colorScheme.background,
              800: Theme.of(context).colorScheme.background,
              900: Theme.of(context).colorScheme.background,
            },
          ),
          
          primaryColor:
              Theme.of(context).colorScheme.background // Ensure full opacity
          ),
      child: Stepper(
        type: StepperType.horizontal, // Set stepper type to horizontal
        steps: [
          Step(
            title: const Text('Step 1'),
            isActive: currentStep >= 0,
            state: currentStep >= 0 ? StepState.complete : StepState.disabled,
            content: const SizedBox(),
          ),
          Step(
            title: const Text('Step 2'),
            isActive: currentStep >= 1,
            state: currentStep >= 1 ? StepState.complete : StepState.disabled,
            content: const SizedBox(),
          ),
          Step(
            title: const Text('Step 3'),
            isActive: currentStep >= 2,
            state: currentStep >= 2 ? StepState.complete : StepState.disabled,
            content: const SizedBox(),
          ),
        ],
        currentStep: currentStep,
        // onStepContinue: () {
        //   setState(() {
        //     if (_currentStep < 2) {
        //       _currentStep += 1;
        //     }
        //   });
        // },
        // onStepCancel: () {
        //   setState(() {
        //     if (_currentStep > 0) {
        //       _currentStep -= 1;
        //     }
        //   });
        // },
      ),
    );
  }
}
