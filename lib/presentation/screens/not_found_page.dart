import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jsimon/config/utils/rive_utils.dart';
import 'package:rive/rive.dart';
import 'package:rive_color_modifier/rive_color_modifier.dart';

class NotFoundPage extends StatefulWidget {
  static const String routeName = 'not_found_page';

  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  Artboard? _notFoundArtboard;
  late SMITrigger jumpOneTrigger;
  late SMITrigger jumpTwoTrigger;

  _load() async {
    final notFoundFile = await RiveFile.asset('assets/rive/404.riv');
    final notFoundArtboard = notFoundFile.artboardByName('404')!;
    StateMachineController controller = RiveUtils.getRiveController(
      notFoundArtboard,
      stateMachineName: '404_Interactivity',
    );

    jumpOneTrigger = controller.findSMI('Jump01') as SMITrigger;
    jumpTwoTrigger = controller.findSMI('Jump02') as SMITrigger;

    setState(() {
      _notFoundArtboard = notFoundArtboard;
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final TextTheme textStyles = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Size size = MediaQuery.sizeOf(context);
    Color backgroundColor =
        isDarkMode ? colors.primaryContainer : colors.primary;

    // Background Accent
    const int clarify = 30;
    int redLight = min(255, backgroundColor.red + clarify);
    int greenLight = min(255, backgroundColor.green + clarify);
    int blueLight = min(255, backgroundColor.blue + clarify);
    Color backgroundAccentColor =
        Color.fromRGBO(redLight, greenLight, blueLight, 1);

    // Shadow
    const int shadowDarken = 50;
    int redDark = max(0, backgroundColor.red - shadowDarken);
    int greenDark = max(0, backgroundColor.green - shadowDarken);
    int blueDark = max(0, backgroundColor.blue - shadowDarken);
    Color shadowColor = Color.fromRGBO(redDark, greenDark, blueDark, 1);

    // Stair Shadow
    const int stairShadowDarken = 100;
    int redStairShadow = max(0, backgroundColor.red - stairShadowDarken);
    int greenStairShadow = max(0, backgroundColor.green - stairShadowDarken);
    int blueStairShadow = max(0, backgroundColor.blue - stairShadowDarken);
    Color stairShadowColor =
        Color.fromRGBO(redStairShadow, greenStairShadow, blueStairShadow, 1);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () {
          if (Random().nextBool()) {
            jumpOneTrigger.fire();
          } else {
            jumpTwoTrigger.fire();
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Opps! Page not found.',
                style: textStyles.displayLarge!.copyWith(
                  color:
                      isDarkMode ? colors.onPrimaryContainer : colors.onPrimary,
                ),
              ),
              if (_notFoundArtboard == null)
                SizedBox(
                  height: size.height * 0.7,
                  width: size.width,
                ),
              if (_notFoundArtboard != null)
                SizedBox(
                  height: size.height * 0.7,
                  width: size.width,
                  child: RiveColorModifier(
                    artboard: _notFoundArtboard!,
                    components: [
                      //* Background
                      RiveColorComponent(
                        shapePattern: 'Background',
                        fillPattern: 'Background Fill',
                        color: backgroundColor,
                      ),
                      //* Background Mask
                      RiveColorComponent(
                        shapePattern: 'Mask',
                        fillPattern: 'Mask Fill',
                        color: backgroundColor,
                      ),
                      //* Number 4 Front
                      RiveColorComponent(
                        shapePattern: '4 Front Up',
                        fillPattern: '4 Front Up Fill',
                        color: backgroundAccentColor,
                      ),
                      RiveColorComponent(
                        shapePattern: '4 Front Lateral',
                        fillPattern: '4 Front Lateral Fill',
                        color: shadowColor,
                      ),
                      //* Number 4 Back
                      RiveColorComponent(
                        shapePattern: '4 Back Up',
                        fillPattern: '4 Back Up Fill',
                        color: backgroundAccentColor,
                      ),
                      RiveColorComponent(
                        shapePattern: '4 Back Lateral',
                        fillPattern: '4 Back Lateral Fill',
                        color: shadowColor,
                      ),
                      //* Plant Right
                      RiveColorComponent(
                        shapePattern: 'Plant R Sheet 1',
                        fillPattern: 'Plant R Sheet 1 Fill',
                        color: backgroundColor,
                      ),
                      RiveColorComponent(
                        shapePattern: 'Plant R Sheet 1 Shadow',
                        fillPattern: 'Plant R Sheet 1 Shadow Fill',
                        color: shadowColor,
                      ),
                      RiveColorComponent(
                        shapePattern: 'Plant R Sheet 2 Shadow',
                        fillPattern: 'Plant R Sheet 2 Shadow Fill',
                        color: shadowColor,
                      ),
                      RiveColorComponent(
                        shapePattern: 'Plant R Sheet 2',
                        fillPattern: 'Plant R Sheet 2 Fill',
                        color: backgroundColor,
                      ),
                      //* Plant Left
                      RiveColorComponent(
                        shapePattern: 'Plant L Sheet 1',
                        fillPattern: 'Plant L Sheet 1 Fill',
                        color: backgroundColor,
                      ),
                      RiveColorComponent(
                        shapePattern: 'Plant L Sheet 2',
                        fillPattern: 'Plant L Sheet 2 Fill',
                        color: backgroundColor,
                      ),
                      RiveColorComponent(
                        shapePattern: 'Plant L Sheet 3',
                        fillPattern: 'Plant L Sheet 3 Fill',
                        color: backgroundColor,
                      ),
                      RiveColorComponent(
                        shapePattern: 'Sheets Shadow',
                        fillPattern: 'Sheets Shadow Fill',
                        color: shadowColor,
                      ),
                      RiveColorComponent(
                        shapePattern: 'Stem Shadow',
                        strokePattern: 'Stem Shadow Stroke',
                        color: shadowColor,
                      ),
                      //* Hole
                      RiveColorComponent(
                        shapePattern: 'Hole',
                        fillPattern: 'Hole Fill',
                        color: shadowColor,
                      ),
                      RiveColorComponent(
                        shapePattern: 'Stair Shadow',
                        strokePattern: 'Stair Shadow Stroke',
                        color: stairShadowColor,
                      ),
                      //* Char 1 and 2 Shadow
                      for (int i = 1; i <= 2; i++)
                        RiveColorComponent(
                          shapePattern: 'Char $i Shadow',
                          fillPattern: 'Char $i Shadow Fill',
                          color: shadowColor,
                        ),
                      //* Char 2 Shadow Jump
                      RiveColorComponent(
                        shapePattern: 'Char 2 Shadow Jump 1',
                        fillPattern: 'Char 2 Shadow Jump 1 Fill',
                        color: shadowColor,
                      ),
                      //* Small Plants
                      for (int i = 1; i <= 8; i++)
                        RiveColorComponent(
                          shapePattern: 'Plants $i',
                          fillPattern: 'Plants Fills $i',
                          color: backgroundColor,
                        ),
                      //* Small Plants Shadow
                      for (int i = 1; i <= 6; i++)
                        RiveColorComponent(
                          shapePattern: 'Plants Shadow $i',
                          fillPattern: 'Plants Shadow Fills $i',
                          color: shadowColor,
                        ),
                    ],
                  ),
                ),
              //* Go to Home
              TextButton(
                onPressed: () {
                  context.go('/');
                },
                child: Text(
                  'Go to Home',
                  style: textStyles.titleLarge!.copyWith(
                    color: isDarkMode
                        ? colors.onPrimaryContainer
                        : colors.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
