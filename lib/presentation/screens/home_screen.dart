import 'dart:async';
import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dev_icons/dev_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jsimon/config/theme/app_theme.dart';
import 'package:jsimon/config/utils/utils.dart';
import 'package:jsimon/l10n/app_localizations.dart';
import 'package:jsimon/presentation/providers/locale_provider.dart';
import 'package:jsimon/widgets/widgets.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:rive/math.dart';
import 'package:rive/rive.dart' hide Image;
import 'package:rive_color_modifier/rive_color_modifier.dart';
import 'package:url_launcher/url_launcher.dart';

Map<String, String> languages = {
  'English': "en",
  'Español': "es",
  '中文': "zh",
  'हिंदी': "hi",
};

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/';

  final GlobalKey _key = GlobalKey();

  HomeScreen({
    super.key,
  });

  @override
  ConsumerState<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final bool _isAppBarExpanded = true;
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _handleListener(_scrollController.offset);
    });
  }

  void _handleListener(double offset) {
    double maxOffset = 150.0;
    if (offset < maxOffset) {
      setState(() {
        _opacity = 1 - (offset / maxOffset);
      });
    } else {
      if (_isAppBarExpanded) {
        setState(() {
          _opacity = 0.0;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.sizeOf(context);

    return ThemeSwitchingArea(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          key: widget._key,
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool isSmallScreen = constraints.maxWidth <= 320;
              final bool isMediumScreen =
                  constraints.maxWidth <= 355 && constraints.maxWidth > 320;
              final bool isLargeScreen = constraints.maxWidth >= 640;

              final double padding = isLargeScreen ? size.width / 2 - 320 : 0;

              return SafeArea(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    //* SLIVER APP BAR
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? padding : 0,
                      ),
                      sliver: CustomSliverAppBar(
                        opacity: _opacity,
                        isSmallScreen: isSmallScreen,
                        isMediumScreen: isMediumScreen,
                        isLargeScreen: isLargeScreen,
                        scrollController: _scrollController,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 30,
                      ),
                    ),

                    //* PHRASE
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isLargeScreen ? padding : 12,
                        ),
                        child: SelectableText(
                          appLocalizations.phrase,
                          style: textStyles.titleLarge,
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 30,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: isLargeScreen ? 70 : 40,
                      ),
                    ),

                    //* EXPERIENCE SECTION
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: BoldTitle(
                          title: '${appLocalizations.expirienceTitle}:',
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      sliver: const TimeLineWidget(),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 40,
                      ),
                    ),

                    //* PROJECTS SECTION
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: BoldTitle(
                          title: '${appLocalizations.projectsTitle}:',
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      sliver: ProjectList(
                        isLargeScreen: isLargeScreen,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 40,
                      ),
                    ),

                    //* TECHNOLOGIES SECTION
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: BoldTitle(
                          title: '${appLocalizations.technologiesTitle}:',
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      sliver: TechnologiesList(
                        wordmark: true,
                        onlyWordmark: true,
                        isLargeScreen: isLargeScreen,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                      ),
                    ),

                    //* CONTACT SECTION
                    ContactSection(
                      isLargeScreen: isLargeScreen,
                      scrollController: _scrollController,
                    ),

                    //* GRACE SPACE
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 30,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ContactSection extends StatefulWidget {
  const ContactSection({
    super.key,
    required this.isLargeScreen,
    required this.scrollController,
  });

  final bool isLargeScreen;
  final ScrollController scrollController;

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  Artboard? _contactArtboard;
  late SMITrigger hoverTrigger;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    //* LOAD CONTACT RIVE FILE
    final contactFile = await RiveFile.asset('assets/rive/contact.riv');
    final artboard = contactFile.artboardByName('Contact')!;
    StateMachineController controller = RiveUtils.getRiveController(
      artboard,
      stateMachineName: 'Bird_Interactivity',
    );

    hoverTrigger = controller.findSMI('hover') as SMITrigger;

    setState(
      () {
        _contactArtboard = artboard;
      },
    );
  }

  void _launchPhone(String phone) async {
    final Uri tel = Uri.parse(phone);

    if (await canLaunchUrl(tel)) {
      await launchUrl(tel);
    } else {
      throw 'Could not launch $phone';
    }
  }

  void _launchMail(String email) async {
    final Uri mail = Uri.parse(email);

    if (await canLaunchUrl(mail)) {
      await launchUrl(mail);
    } else {
      throw 'Could not launch $email';
    }
  }

  void _launchUrl(String link) async {
    final Uri url = Uri.parse(link);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final appLocalizations = AppLocalizations.of(context)!;

    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* CUSTOM DIVIDER
          const CustomDivider(),
          const SizedBox(height: 20),
          //* CONTACT ME TITLE & GO TO TOP BUTTON
          Center(
            child: SizedBox(
              width: 640,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* CONTACT ME TITLE
                  BoldTitle(title: '${appLocalizations.contactTitle}:'),
                  //* GO TO TOP BUTTON
                  GoToTopButton(
                    scrollController: widget.scrollController,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          //* CONTACT ME SECTION
          Center(
            child: SizedBox(
              width: 640,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* DESCRIPTION & RIVE BIRD
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //* DESCRIPTION TEXT
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 12.0,
                            right: 8.0,
                            bottom: 8.0,
                          ),
                          child: SelectableText(
                              appLocalizations.contactDescription),
                        ),
                        //* RIVE BIRD
                        Center(
                          child: SizedBox.fromSize(
                            size: const Size(60, 134),
                            child: MouseRegion(
                              onHover: (_) => hoverTrigger.fire(),
                              child: _contactArtboard != null
                                  ? RiveColorModifier(
                                      alignment: Alignment.center,
                                      artboard: _contactArtboard!,
                                      fit: BoxFit.cover,
                                      components: [
                                        RiveColorComponent(
                                          shapePattern: 'Button',
                                          fillPattern: 'Button Background Fill',
                                          color: colors.primary,
                                        ),
                                        RiveColorComponent(
                                          shapePattern: 'Text 1',
                                          fillPattern: 'Text Fill 1',
                                          color: colors.onPrimary,
                                        ),
                                        RiveColorComponent(
                                          shapePattern: 'Text 2',
                                          fillPattern: 'Text Fill 2',
                                          color: colors.onPrimary,
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //* CONTACT ACTIONS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //* PHONE
                        ContactAction(
                          icon: Symbols.phone,
                          text: "+1 (849) 527-1701",
                          onTap: () => _launchPhone('tel:+18495271701'),
                        ),
                        //* EMAIL
                        ContactAction(
                          icon: Symbols.email,
                          text: "jsimondev@gmail.com",
                          onTap: () =>
                              _launchMail('mailto:jsimondev@gmail.com'),
                        ),
                        //* SOCIAL MEDIA
                        ContactAction(
                          icon: DevIcons.githubOriginal,
                          text: "GitHub",
                          onTap: () =>
                              _launchUrl('https://github.com/JSimonDev'),
                        ),
                        //* TELEGRAM
                        ContactAction(
                          icon: Symbols.send,
                          text: "Telegram",
                          onTap: () => _launchUrl('https://t.me/MRPDWKDP'),
                        ),
                        //* LICENSE
                        ContactAction(
                          icon: Symbols.info,
                          text: appLocalizations.licenseButtonLabel,
                          onTap: () => showLicensePage(
                            context: context,
                          ),
                        ),
                        //* LIFE POLICIES
                        ContactAction(
                          icon: Symbols.policy,
                          text: AppLocalizations.of(context)!.lifePolicies,
                          onTap: () =>
                              _launchUrl('https://ian.hixie.ch/bible/policies'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          //* DIVIDER
          const Center(
            child: SizedBox(
              width: 640,
              child: Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),
          //* FOOTER
          Center(
            child: SizedBox(
              width: 640,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(appLocalizations.footerPhrasePart1),
                  //* HEART RIVE ANIMATION
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: RiveAnimation.asset(
                      artboard: 'Heart',
                      'assets/rive/heart.riv',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      onInit: (artboard) {
                        artboard.addController(
                          SimpleAnimation('Spin_Idle'),
                        );
                      },
                    ),
                  ),
                  SelectableText(appLocalizations.footerPhrasePart2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoToTopButton extends StatelessWidget {
  const GoToTopButton({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return TextButton(
      style: const ButtonStyle(
        visualDensity: VisualDensity.comfortable,
        enableFeedback: true,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.only(right: 10.0, left: 0.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Symbols.arrow_drop_up_rounded,
          ),
          Text(
            appLocalizations.goToTopButtonLabel,
          ),
        ],
      ),
      onPressed: () {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }
}

class ContactAction extends StatelessWidget {
  const ContactAction({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.padding = const EdgeInsets.only(
      top: 8.0,
      left: 8.0,
      right: 8.0,
    ),
  });

  final IconData icon;
  final String text;
  final void Function() onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Padding(
      padding: padding,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                text,
                style: textStyles.bodyMedium!.copyWith(
                  color: colors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: colors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDivider extends StatefulWidget {
  const CustomDivider({
    super.key,
  });

  @override
  State<CustomDivider> createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  Artboard? _eyeArtboard;
  late StateMachineController _controller;
  late SMIBool pressedTrigger;
  bool isClicked = false;
  MouseCursor cursorType = SystemMouseCursors.click;

  Future<void> _load() async {
    //* LOAD QUOTATION RIVE FILE
    final eyeFile = await RiveFile.asset('assets/rive/eye.riv');
    final artboard = eyeFile.mainArtboard;
    StateMachineController controller = RiveUtils.getRiveController(
      artboard,
      stateMachineName: 'EYE_Interactivity',
    );

    _controller = controller;

    pressedTrigger = controller.findSMI('Pressed') as SMIBool;

    setState(
      () {
        _eyeArtboard = artboard;
      },
    );
  }

  void move(Offset pointer) => _controller.pointerMoveFromOffset(pointer);

  void onTapDown(TapDownDetails details) {
    if (details.kind == PointerDeviceKind.touch) {
      move(details.localPosition);
    }
  }

  void _updateCursorType(MouseCursor newCursorType) {
    setState(() {
      cursorType = newCursorType;
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: size.width,
      child: Row(
        children: [
          Expanded(
            child: CustomPaint(
              size: Size(size.width, 30),
              painter: WavyLinePainter(
                direction: LineDirection.ltr,
                color: colors.primary,
              ),
            ),
          ),
          //* EYE RIVE ANIMATION
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: colors.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: OverflowBox(
                maxHeight: 500,
                maxWidth: 500,
                child: SizedBox(
                  width: 500,
                  height: 500,
                  child: MouseRegion(
                    cursor: cursorType,
                    opaque: true,
                    onHover: (event) => move(event.localPosition),
                    child: GestureDetector(
                      onTap: () {
                        pressedTrigger.change(!pressedTrigger.value);
                        _updateCursorType(isClicked
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.basic);
                        isClicked = !isClicked;
                      },
                      onTapDown: onTapDown,
                      onPanUpdate: (details) => move(details.localPosition),
                      child: _eyeArtboard != null
                          ? RiveColorModifier(
                              artboard: _eyeArtboard!,
                              fit: BoxFit.scaleDown,
                              components: [
                                RiveColorComponent(
                                  shapePattern: 'Eye Pupil Off',
                                  fillPattern: 'Pupil Fill',
                                  color: colors.primary,
                                ),
                                RiveColorComponent(
                                  shapePattern: 'Eye Border Off',
                                  strokePattern: 'Eye Border Stroke',
                                  color: colors.primary,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomPaint(
              size: Size(size.width, 30),
              painter: WavyLinePainter(
                direction: LineDirection.rtl,
                color: colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectList extends StatelessWidget {
  const ProjectList({
    super.key,
    required this.isLargeScreen,
  });

  final bool isLargeScreen;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    Set<Map<String, String>> projects = {
      {
        'name': appLocalizations.frescomaxName,
        'description': appLocalizations.frescomaxProjectDescription,
        'image': 'assets/frescomax.webp',
        'alt': 'Frescomax App Mockup',
        'link': 'https://frescomax.shop',
        'playStore':
            'https://play.google.com/store/apps/details?id=dev.jsimon.frescomax',
        'appStore': 'https://apps.apple.com/do/app/frescomax/id6754563826',
      },
      {
        'name': appLocalizations.cotizameName,
        'description': appLocalizations.cotizameProjectDescription,
        'image': 'assets/cotizame.webp',
        'alt': 'Cotízame App Mockup',
        'link': 'https://cotizame.com.do',
        'playStore':
            'https://play.google.com/store/apps/details?id=com.xutrom.cotizame',
        'appStore': 'https://apps.apple.com/do/app/cotízame/id6739175202',
      },
      {
        'name': appLocalizations.riveColorModifierProjectName,
        'description': appLocalizations.riveColorModifierProjectDescription,
        'image': 'assets/rive_color_modifier_poster.webp',
        'alt': 'Rive Color Modifier Showcase',
        'github': 'https://github.com/JSimonDev/rive_color_modifier',
      },
      // {
      //   'name': appLocalizations.cinemapediaName,
      //   'description': appLocalizations.cinemapediaProjectDescription,
      //   'image': 'assets/cinemapedia.webp',
      //   'alt': 'Cinemapedia App Mockup',
      //   'github': 'https://github.com/JSimonDev/cinemapedia',
      // },
    };

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      sliver: SliverMasonryGrid.count(
        mainAxisSpacing: 10.0,
        crossAxisCount: isLargeScreen ? 1 : 1,
        childCount: projects.length,
        itemBuilder: (context, index) {
          return ExpandableCard(
            isLargeScreen: isLargeScreen,
            image: projects.elementAt(index)['image']!,
            name: projects.elementAt(index)['name']!,
            description: projects.elementAt(index)['description']!,
            githubUrl: projects.elementAt(index)['github'],
            linkUrl: projects.elementAt(index)['link'],
            playStoreUrl: projects.elementAt(index)['playStore'],
            appStoreUrl: projects.elementAt(index)['appStore'],
          );
        },
      ),
    );
  }
}

class ExpandableCard extends StatefulWidget {
  const ExpandableCard({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.isLargeScreen,
    required this.githubUrl,
    required this.linkUrl,
    this.playStoreUrl,
    this.appStoreUrl,
  });

  final String image;
  final String name;
  final String description;
  final bool isLargeScreen;
  final String? githubUrl;
  final String? linkUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _showMore = false;

  void _launchUrl(String link) async {
    final Uri url = Uri.parse(link);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    const int wordLimit = 200;
    final TextTheme textStyles = Theme.of(context).textTheme;
    final String shortDescription = widget.description.length > wordLimit
        ? '${widget.description.substring(0, wordLimit)}...'
        : widget.description;
    final String longDescription = widget.description;
    const buttonShape = WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
    );

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        child: Column(
          children: [
            //* IMAGE
            Image.asset(
              width: double.infinity,
              widget.image,
              fit: BoxFit.fitWidth,
            ),
            //* DESCRIPTION & BUTTONS
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* NAME
                  SelectableText(
                    widget.name,
                    style: textStyles.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  //* DESCRIPTION
                  AnimatedCrossFade(
                    firstChild: SelectableText(shortDescription),
                    secondChild: SelectableText(longDescription),
                    crossFadeState: _showMore || widget.isLargeScreen
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                    firstCurve: Curves.fastOutSlowIn,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //* BUTTONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //* LINK BUTTON
                      if (widget.linkUrl != null)
                        widget.isLargeScreen
                            ? TextButton.icon(
                                style: const ButtonStyle(
                                  visualDensity: VisualDensity.comfortable,
                                  enableFeedback: true,
                                  shape: buttonShape,
                                ),
                                icon: const Icon(
                                  Symbols.captive_portal_rounded,
                                ),
                                label: Text(
                                  appLocalizations.goToWebsiteButtonLabel,
                                ),
                                onPressed: () => _launchUrl(widget.linkUrl!),
                              )
                            : IconButton(
                                icon:
                                    const Icon(Symbols.captive_portal_rounded),
                                tooltip:
                                    appLocalizations.goToWebsiteButtonLabel,
                                onPressed: () => _launchUrl(widget.linkUrl!),
                              ),

                      //* GITHUB BUTTON
                      if (widget.githubUrl != null)
                        widget.isLargeScreen
                            ? TextButton.icon(
                                style: const ButtonStyle(
                                  visualDensity: VisualDensity.comfortable,
                                  enableFeedback: true,
                                  shape: buttonShape,
                                ),
                                icon: const Icon(
                                  DevIcons.githubOriginal,
                                ),
                                label: const Text(
                                  'GitHub',
                                ),
                                onPressed: () => _launchUrl(widget.githubUrl!),
                              )
                            : IconButton(
                                icon: const Icon(DevIcons.githubOriginal),
                                tooltip: 'GitHub',
                                onPressed: () => _launchUrl(widget.githubUrl!),
                              ),

                      //* PLAY STORE BUTTON
                      if (widget.playStoreUrl != null) ...[
                        const SizedBox(width: 8),
                        widget.isLargeScreen
                            ? TextButton.icon(
                                style: const ButtonStyle(
                                  visualDensity: VisualDensity.comfortable,
                                  enableFeedback: true,
                                  shape: buttonShape,
                                ),
                                icon: const Icon(
                                  FontAwesomeIcons.googlePlay,
                                ),
                                label: const Text(
                                  'Play Store',
                                ),
                                onPressed: () =>
                                    _launchUrl(widget.playStoreUrl!),
                              )
                            : IconButton(
                                icon: const Icon(FontAwesomeIcons.googlePlay),
                                tooltip: 'Play Store',
                                iconSize: 20,
                                onPressed: () =>
                                    _launchUrl(widget.playStoreUrl!),
                              ),
                      ],
                      //* APP STORE BUTTON
                      if (widget.appStoreUrl != null) ...[
                        const SizedBox(width: 8),
                        widget.isLargeScreen
                            ? TextButton.icon(
                                style: const ButtonStyle(
                                  visualDensity: VisualDensity.comfortable,
                                  enableFeedback: true,
                                  shape: buttonShape,
                                ),
                                icon: const Icon(
                                  FontAwesomeIcons.appStore,
                                ),
                                label: const Text(
                                  'App Store',
                                ),
                                onPressed: () =>
                                    _launchUrl(widget.appStoreUrl!),
                              )
                            : IconButton(
                                icon: const Icon(FontAwesomeIcons.appStoreIos),
                                iconSize: 22,
                                tooltip: 'App Store',
                                onPressed: () =>
                                    _launchUrl(widget.appStoreUrl!),
                              ),
                      ],
                      const SizedBox(width: 8),
                      //* SHOW MORE BUTTON
                      if (widget.description.length > wordLimit &&
                          !widget.isLargeScreen)
                        TextButton(
                          style: const ButtonStyle(
                            visualDensity: VisualDensity.comfortable,
                            enableFeedback: true,
                            shape: buttonShape,
                          ),
                          child: Text(
                            _showMore ? 'Mostrar menos' : 'Mostrar más',
                          ),
                          onPressed: () {
                            setState(() {
                              _showMore = !_showMore;
                            });
                          },
                        ),
                      if (!widget.isLargeScreen) const SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeLineWidget extends StatelessWidget {
  const TimeLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final appLocalizations = AppLocalizations.of(context)!;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Timeline(
          physics: const NeverScrollableScrollPhysics(),
          indicatorColor: colors.primary,
          indicatorSize: 20,
          strokeCap: StrokeCap.round,
          lineColor: colors.primary.withValues(alpha: 0.5),
          lineGap: 10,
          children: [
            //* FRESCOMAX
            TimeLineCard(
              proyectName: appLocalizations.frescomaxName,
              role: appLocalizations.frescomaxRole,
              timelapse: appLocalizations.frescomaxTimelapse,
              description: appLocalizations.frescomaxExperienceDescription,
            ),
            //* COTIZAME APP
            TimeLineCard(
              proyectName: appLocalizations.cotizameName,
              role: appLocalizations.cotizameRole,
              timelapse: appLocalizations.cotizameTimelapse,
              description: appLocalizations.cotizameExperienceDescription,
            ),
            //* FREELANCE
            TimeLineCard(
              proyectName: appLocalizations.freelanceName,
              role: appLocalizations.freelanceRole,
              timelapse: appLocalizations.freelanceTimelapse,
              description: appLocalizations.freelanceExperienceDescription,
            ),
          ],
        ),
      ),
    );
  }
}

class TimeLineCard extends StatelessWidget {
  const TimeLineCard({
    super.key,
    required this.proyectName,
    required this.role,
    required this.timelapse,
    required this.description,
  });

  final String proyectName;
  final String role;
  final String timelapse;
  final String description;

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;
    const double radius = 20;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        ),
        side: BorderSide(
          color: colors.primary.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: IntrinsicWidth(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          proyectName,
                          style: textStyles.titleMedium,
                        ),
                        SelectableText(
                          role,
                          style: textStyles.bodySmall!.copyWith(
                            color: colors.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SelectableText(
                    timelapse,
                    style: textStyles.bodyMedium!.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 15.0,
              ),
              child: SelectableText(
                description,
                style: textStyles.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required double opacity,
    required this.isSmallScreen,
    required this.isMediumScreen,
    required this.isLargeScreen,
    required this.scrollController,
  }) : _opacity = opacity;

  final double _opacity;
  final bool isSmallScreen;
  final bool isMediumScreen;
  final bool isLargeScreen;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      pinned: true,
      collapsedHeight: 70,
      expandedHeight: isLargeScreen ? 280 : 200.0,
      leadingWidth: 100,
      leading: Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: AppBarLeadingButton(
          opacity: _opacity,
        ),
      ),
      actions: [
        if (!isSmallScreen)
          ContactButton(
            scrollController: scrollController,
          ),
        SizedBox(
          width: isLargeScreen
              ? 10
              : isMediumScreen || isSmallScreen
                  ? 0
                  : 5,
        ),
        const TheSwitcherButton(),
        SizedBox(
          width: isMediumScreen || isSmallScreen ? 0 : 5,
        ),
      ],
      flexibleSpace: SliverAppBarTitle(
        isLargeScreen: isLargeScreen,
        isMediumScreen: isMediumScreen,
        isSmallScreen: isSmallScreen,
      ),
    );
  }
}

class TheSwitcherButton extends StatelessWidget {
  const TheSwitcherButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final keyValueStorageService = KeyValueStorageServiceImpl();

    //* LIGHT THEME
    final ThemeData appThemeLight = AppTheme(
      isDarkMode: false,
    ).getTheme();

    //* DARK THEME
    final ThemeData appThemeDark = AppTheme(
      isDarkMode: true,
    ).getTheme();

    return ThemeSwitcher.switcher(
      builder: (context, switcher) {
        return IconButton(
          onPressed: () async {
            await keyValueStorageService.setKeyValue<bool>(
              'isDarkMode',
              !isDarkMode,
            );

            switcher.changeTheme(
              isReversed: isDarkMode ? true : false,
              theme: isDarkMode ? appThemeLight : appThemeDark,
            );
          },
          icon: Icon(
            isDarkMode ? Symbols.wb_sunny_rounded : Symbols.nights_stay_rounded,
          ),
        );
      },
    );
  }
}

class ContactButton extends StatelessWidget {
  const ContactButton({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    const BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
      bottomLeft: Radius.circular(20),
    );

    return FilledButton(
      style: const ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        enableFeedback: true,
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
        ),
        visualDensity: VisualDensity.comfortable,
      ),
      onPressed: () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 200,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: Text(
        appLocalizations.contactButtonLabel,
      ),
    );
  }
}

class SelectLanguageButton extends ConsumerStatefulWidget {
  const SelectLanguageButton({super.key});

  @override
  ConsumerState<SelectLanguageButton> createState() =>
      _SelectLanguageButtonState();
}

class _SelectLanguageButtonState extends ConsumerState<SelectLanguageButton> {
  late String dropdownValue;
  final keyValueStorageService = KeyValueStorageServiceImpl();

  @override
  void initState() {
    final localeState = ref.read(myLocaleProvider);
    dropdownValue = languages.keys
        .firstWhere((key) => languages[key] == localeState.languageCode);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final localeState = ref.watch(myLocaleProvider);
    dropdownValue = languages.keys
        .firstWhere((key) => languages[key] == localeState.languageCode);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final MyLocale localeNotifier = ref.read(myLocaleProvider.notifier);

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        disabledHint: Text(dropdownValue),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        borderRadius: BorderRadius.circular(10),
        iconEnabledColor: colors.primary,
        value: dropdownValue,
        style: TextStyle(
          color: colors.primary,
        ),
        underline: const SizedBox.shrink(),
        onChanged: (String? value) async {
          await keyValueStorageService.setKeyValue<String>(
            'language',
            languages[value]!,
          );

          setState(() {
            dropdownValue = value!;
            localeNotifier.changeLocale(Locale(languages[value]!));
          });
        },
        items: List.generate(
          languages.keys.length,
          (index) {
            final String key = languages.keys.elementAt(index);
            return DropdownMenuItem(
              value: key,
              child: Text(key),
            );
          },
        ),
      ),
    );
  }
}

class AppBarLeadingButton extends StatelessWidget {
  const AppBarLeadingButton({
    super.key,
    required double opacity,
  }) : _opacity = opacity;

  final double _opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: IgnorePointer(
        ignoring: _opacity <= 0.3,
        child: const SelectLanguageButton(),
      ),
    );
  }
}

class BoldTitle extends StatelessWidget {
  final String title;

  const BoldTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SelectableText(
        title,
        style: textStyles.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationThickness: 1,
          decorationColor: colors.primary,
        ),
      ),
    );
  }
}

class TechnologiesList extends StatefulWidget {
  const TechnologiesList({
    super.key,
    required this.isLargeScreen,
    this.wordmark = false,
    this.onlyWordmark = false,
  });

  final bool isLargeScreen;
  final bool wordmark;
  final bool onlyWordmark;

  @override
  State<TechnologiesList> createState() => _TechnologiesListState();
}

class _TechnologiesListState extends State<TechnologiesList> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  late int _currentItem = 0;
  double itemExtent = 100.0;
  bool userScrolling = false;
  MouseCursor cursorType = SystemMouseCursors.grab;

  //* Map with all the techs I have worked with
  static Set<Map<String, dynamic>> techs = {
    {
      'nombre': 'Dart',
      'icon': DevIcons.dartPlain,
      'wordmark': DevIcons.dartPlainWordmark,
      'doc': 'https://dart.dev/',
      'alt': 'Dart Logo',
    },
    {
      'nombre': 'Flutter',
      'icon': DevIcons.flutterPlain,
      'wordmark': DevIcons.flutterPlain,
      'doc': 'https://flutter.dev/',
      'alt': 'Flutter Logo',
    },
    {
      'nombre': 'Ionic',
      'icon': DevIcons.ionicOriginal,
      'wordmark': DevIcons.ionicOriginalWordmark,
      'doc': 'https://ionic.io/docs',
      'alt': 'Ionic Logo',
    },
    {
      'nombre': 'Firebase',
      'icon': DevIcons.firebasePlain,
      'wordmark': DevIcons.firebasePlainWordmark,
      'doc': 'https://firebase.google.com/',
      'alt': 'Firebase Logo',
    },
    {
      'nombre': 'AWS',
      'icon': FontAwesomeIcons.aws,
      'wordmark': FontAwesomeIcons.aws,
      'doc': 'https://aws.amazon.com/',
      'alt': 'AWS Logo',
    },
    {
      'nombre': 'NPM',
      'icon': DevIcons.npmOriginalWordmark,
      'wordmark': DevIcons.npmOriginalWordmark,
      'doc': 'https://docs.npmjs.com/',
      'alt': 'NPM Logo',
    },
    {
      'nombre': 'Node.js',
      'icon': DevIcons.nodejsPlain,
      'wordmark': DevIcons.nodejsPlainWordmark,
      'doc': 'https://nodejs.org/docs/latest/api/',
      'alt': 'Node.js Logo',
    },
    {
      'nombre': 'Express.js',
      'icon': DevIcons.expressOriginal,
      'wordmark': DevIcons.expressOriginalWordmark,
      'doc': 'https://expressjs.com/',
      'alt': 'Express.js Logo',
    },
    {
      'nombre': 'MongoDB',
      'icon': DevIcons.mongodbPlain,
      'wordmark': DevIcons.mongodbPlainWordmark,
      'doc': 'https://www.mongodb.com/',
      'alt': 'MongoDB Logo',
    },
    {
      'nombre': 'Git',
      'icon': DevIcons.gitPlain,
      'wordmark': DevIcons.gitPlainWordmark,
      'doc': 'https://git-scm.com/',
      'alt': 'Git Logo',
    },
    {
      'nombre': 'GitHub',
      'icon': DevIcons.githubOriginal,
      'wordmark': DevIcons.githubOriginalWordmark,
      'doc': 'https://docs.github.com/',
      'alt': 'GitHub Logo',
    },
    // {
    //   'nombre': 'Python',
    //   'icon': DevIcons.pythonPlain,
    //   'wordmark': DevIcons.pythonPlainWordmark,
    //   'doc': 'https://www.python.org/',
    //   'alt': 'Python Logo',
    // },
    {
      'nombre': 'HTML',
      'icon': DevIcons.html5Plain,
      'wordmark': DevIcons.html5PlainWordmark,
      'doc': 'https://developer.mozilla.org/en-US/docs/Web/HTML',
      'alt': 'HTML Logo',
    },
    {
      'nombre': 'CSS',
      'icon': DevIcons.css3Plain,
      'wordmark': DevIcons.css3PlainWordmark,
      'doc': 'https://developer.mozilla.org/en-US/docs/Web/CSS',
      'alt': 'CSS Logo',
    },
    {
      'nombre': 'JavaScript',
      'icon': DevIcons.javascriptPlain,
      'wordmark': DevIcons.javascriptPlain,
      'doc': 'https://developer.mozilla.org/en-US/docs/Web/JavaScript',
      'alt': 'JavaScript Logo',
    },
    {
      'nombre': 'TypeScript',
      'icon': DevIcons.typescriptPlain,
      'wordmark': DevIcons.typescriptPlain,
      'doc': 'https://www.typescriptlang.org/docs/',
      'alt': 'TypeScript Logo',
    },
    {
      'nombre': 'Tailwind CSS',
      'icon': DevIcons.tailwindcssPlain,
      'wordmark': DevIcons.tailwindcssOriginalWordmark,
      'doc': 'https://tailwindcss.com/docs/installation',
      'alt': 'Tailwind CSS Logo',
    }
  };

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void _updateCursorType(MouseCursor newCursorType) {
    setState(() {
      cursorType = newCursorType;
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      if (!userScrolling) {
        _moveToNextItem();
      }
    });

    _scrollController.addListener(_scrollListener);
  }

  void _moveToNextItem() {
    _currentItem++;
    if (_currentItem >= techs.length * 3 && _scrollController.hasClients) {
      _currentItem = 0;
      _scrollController.jumpTo(_currentItem * itemExtent);
    } else if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _currentItem * itemExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection !=
        ScrollDirection.idle) {
      if (!userScrolling) {
        userScrolling = true;
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = Theme.of(context).textTheme;
    const double radius = 20;

    final List<Map<String, dynamic>> loopTechs = widget.isLargeScreen
        ? [
            ...techs,
            ...techs,
            ...techs,
          ]
        : [...techs];

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Listener(
          onPointerUp: (event) => _updateCursorType(SystemMouseCursors.grab),
          onPointerDown: (event) =>
              _updateCursorType(SystemMouseCursors.grabbing),
          child: MouseRegion(
            cursor: cursorType,
            child: RotatedBox(
              quarterTurns: -1,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification is UserScrollNotification) {
                    switch (notification.direction) {
                      case ScrollDirection.idle:
                        if (userScrolling) {
                          userScrolling = false;
                          _currentItem =
                              (_scrollController.offset / itemExtent).round();
                        }
                        break;
                      case ScrollDirection.forward:
                        userScrolling = true;
                        break;
                      case ScrollDirection.reverse:
                        userScrolling = true;
                        break;
                    }
                  }
                  return true;
                },
                child: ListWheelScrollView.useDelegate(
                  scrollBehavior: const MaterialScrollBehavior().copyWith(
                    scrollbars: false,
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  controller: _scrollController,
                  diameterRatio: 2,
                  perspective: 0.003,
                  clipBehavior: Clip.antiAlias,
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: loopTechs.map((tech) {
                      final bool isIconEqualWordmark =
                          tech['icon'] == tech['wordmark'];

                      return RotatedBox(
                        quarterTurns: 1,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: GestureDetector(
                            onTap: () {
                              final Uri url = Uri.parse(tech['doc']);

                              _launchUrl(url);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(radius),
                                  bottomRight: Radius.circular(radius),
                                  bottomLeft: Radius.circular(radius),
                                ),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 0.5,
                                ),
                              ),
                              child: widget.wordmark && !isIconEqualWordmark ||
                                      widget.onlyWordmark
                                  ? Icon(
                                      tech['wordmark'],
                                      size: isIconEqualWordmark ? 50 : 60,
                                    )
                                  : Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10.0,
                                            ),
                                            child: Icon(
                                              tech['icon'],
                                              size: widget.isLargeScreen
                                                  ? 50
                                                  : 40,
                                              // color: colors.primary,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            tech['nombre'],
                                            style: widget.isLargeScreen
                                                ? textStyles.titleLarge
                                                : textStyles.bodyLarge,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      );
                    }).toList(), // puedes ajustar este valor según tus necesidades
                  ),
                  itemExtent: itemExtent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SliverAppBarTitle extends StatelessWidget {
  const SliverAppBarTitle({
    super.key,
    required this.isLargeScreen,
    required this.isMediumScreen,
    required this.isSmallScreen,
  });

  final bool isLargeScreen;
  final bool isMediumScreen;
  final bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      expandedTitleScale: isLargeScreen
          ? 2
          : isMediumScreen || isSmallScreen
              ? 1.2
              : 1.5,
      titlePadding: const EdgeInsets.all(0),
      title: Padding(
        padding: EdgeInsets.fromLTRB(
          isMediumScreen || isSmallScreen ? 5 : 10,
          10,
          10,
          10,
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppBarCircleAvatar(),
              SizedBox(
                width: isMediumScreen || isSmallScreen ? 5 : 10,
              ),
              AppBarName(isLargeScreen: isLargeScreen),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarCircleAvatar extends StatefulWidget {
  const AppBarCircleAvatar({
    super.key,
  });

  @override
  State<AppBarCircleAvatar> createState() => _AppBarCircleAvatarState();
}

class _AppBarCircleAvatarState extends State<AppBarCircleAvatar> {
  Artboard? _myAvatarArtboard;
  late SMIBool _isHovering;
  late SMIBool _isPressed;

  @override
  initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final riveFile = await RiveFile.asset('assets/rive/profile_pic.riv');
    final artboard = riveFile.artboardByName('Main')!;
    final controller = RiveUtils.getRiveController(
      artboard,
      stateMachineName: 'State Machine 1',
    );

    _isHovering = controller.findSMI('isHovering') as SMIBool;
    _isPressed = controller.findSMI('active') as SMIBool;
    _myAvatarArtboard = artboard;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    const double radius = 20;

    return _myAvatarArtboard != null
        ? MouseRegion(
            onEnter: (event) {
              if (event.kind == PointerDeviceKind.mouse) {
                _isHovering.change(true);
              }
            },
            onExit: (event) {
              if (event.kind == PointerDeviceKind.mouse) {
                _isHovering.change(false);
              }
            },
            child: TapRegion(
              onTapInside: (event) {
                if (event.kind == PointerDeviceKind.touch) {
                  _isHovering.change(true);

                  _isPressed.change(!_isPressed.value);
                }
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                radius: 28,
                child: RiveColorModifier(
                  artboard: _myAvatarArtboard!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        : CircleAvatar(
            radius: radius + 6,
            backgroundColor: colors.primary.withValues(alpha: 0.1),
            child: CircleAvatar(
              radius: radius + 3,
              backgroundColor: colors.primary.withValues(alpha: 0.5),
              child: const CircleAvatar(
                radius: radius,
                backgroundImage: AssetImage(
                  'assets/portafolio.webp',
                ),
              ),
            ),
          );
  }
}

class AppBarName extends StatelessWidget {
  const AppBarName({
    super.key,
    required this.isLargeScreen,
  });

  final bool isLargeScreen;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textStyles = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context)!;

    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            appLocalizations.name,
            style: textStyles.titleLarge!.copyWith(
              fontFamily: 'Cookie',
              letterSpacing: 1.0,
            ),
            maxLines: 1,
          ),
          SelectableText(
            isLargeScreen
                ? appLocalizations.roleLarge
                : appLocalizations.roleSmall,
            style: textStyles.labelSmall!.copyWith(
              color: colors.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

extension StateMachineControllerX on StateMachineController {
  void pointerMoveFromOffset(Offset pointerOffset) => pointerMove(
        Vec2D.fromValues(pointerOffset.dx, pointerOffset.dy),
      );

  SMITrigger? findTrigger(String name) {
    final trigger = findInput<bool>(name);

    return trigger is SMITrigger? ? trigger : null;
  }
}
