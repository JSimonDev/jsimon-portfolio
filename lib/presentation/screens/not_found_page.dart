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
                        shapeName: 'Background',
                        fillName: 'Background Fill',
                        color: backgroundColor,
                      ),
                      //* Background Mask
                      RiveColorComponent(
                        shapeName: 'Mask',
                        fillName: 'Mask Fill',
                        color: backgroundColor,
                      ),
                      //* Number 4 Front
                      RiveColorComponent(
                        shapeName: '4 Front Up',
                        fillName: '4 Front Up Fill',
                        color: backgroundAccentColor,
                      ),
                      RiveColorComponent(
                        shapeName: '4 Front Lateral',
                        fillName: '4 Front Lateral Fill',
                        color: shadowColor,
                      ),
                      //* Number 4 Back
                      RiveColorComponent(
                        shapeName: '4 Back Up',
                        fillName: '4 Back Up Fill',
                        color: backgroundAccentColor,
                      ),
                      RiveColorComponent(
                        shapeName: '4 Back Lateral',
                        fillName: '4 Back Lateral Fill',
                        color: shadowColor,
                      ),
                      //* Plant Right
                      RiveColorComponent(
                        shapeName: 'Plant R Sheet 1',
                        fillName: 'Plant R Sheet 1 Fill',
                        color: backgroundColor,
                      ),
                      RiveColorComponent(
                        shapeName: 'Plant R Sheet 1 Shadow',
                        fillName: 'Plant R Sheet 1 Shadow Fill',
                        color: shadowColor,
                      ),
                      RiveColorComponent(
                        shapeName: 'Plant R Sheet 2 Shadow',
                        fillName: 'Plant R Sheet 2 Shadow Fill',
                        color: shadowColor,
                      ),
                      RiveColorComponent(
                        shapeName: 'Plant R Sheet 2',
                        fillName: 'Plant R Sheet 2 Fill',
                        color: backgroundColor,
                      ),
                      //* Plant Left
                      RiveColorComponent(
                        shapeName: 'Plant L Sheet 1',
                        fillName: 'Plant L Sheet 1 Fill',
                        color: backgroundColor,
                      ),
                      RiveColorComponent(
                        shapeName: 'Plant L Sheet 2',
                        fillName: 'Plant L Sheet 2 Fill',
                        color: backgroundColor,
                      ),
                      RiveColorComponent(
                        shapeName: 'Plant L Sheet 3',
                        fillName: 'Plant L Sheet 3 Fill',
                        color: backgroundColor,
                      ),
                      RiveColorComponent(
                        shapeName: 'Sheets Shadow',
                        fillName: 'Sheets Shadow Fill',
                        color: shadowColor,
                      ),
                      RiveColorComponent(
                        shapeName: 'Stem Shadow',
                        strokeName: 'Stem Shadow Stroke',
                        color: shadowColor,
                      ),
                      //* Hole
                      RiveColorComponent(
                        shapeName: 'Hole',
                        fillName: 'Hole Fill',
                        color: shadowColor,
                      ),
                      RiveColorComponent(
                        shapeName: 'Stair Shadow',
                        strokeName: 'Stair Shadow Stroke',
                        color: stairShadowColor,
                      ),
                      //* Char 1 and 2 Shadow
                      for (int i = 1; i <= 2; i++)
                        RiveColorComponent(
                          shapeName: 'Char $i Shadow',
                          fillName: 'Char $i Shadow Fill',
                          color: shadowColor,
                        ),
                      //* Char 2 Shadow Jump
                      RiveColorComponent(
                        shapeName: 'Char 2 Shadow Jump 1',
                        fillName: 'Char 2 Shadow Jump 1 Fill',
                        color: shadowColor,
                      ),
                      //* Small Plants
                      for (int i = 1; i <= 8; i++)
                        RiveColorComponent(
                          shapeName: 'Plants $i',
                          fillName: 'Plants Fills $i',
                          color: backgroundColor,
                        ),
                      //* Small Plants Shadow
                      for (int i = 1; i <= 6; i++)
                        RiveColorComponent(
                          shapeName: 'Plants Shadow $i',
                          fillName: 'Plants Shadow Fills $i',
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
