import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dev_icons/dev_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jsimon/config/theme/app_theme.dart';
import 'package:jsimon/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<HomeScreenState> homeScreenKey = GlobalKey();

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final bool _isAppBarExpanded = true;
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _handleListener();
    });
  }

  void _handleListener() {
    double offset = _scrollController.offset;
    double maxOffset = 100.0;
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
    _scrollController.removeListener(() {
      _handleListener();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        key: homeScreenKey,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool isLargeScreen = constraints.maxWidth > 640;
            final bool isExtraLargeScreen = constraints.maxWidth > 640;

            if (isLargeScreen || isExtraLargeScreen) {
              return Scrollbar(
                controller: _scrollController,
                child: Center(
                  child: SizedBox(
                    width: 640,
                    child: buildBody(context, isLargeScreen),
                  ),
                ),
              );
            } else {
              return buildBody(context, isLargeScreen);
            }
          },
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, bool isLargeScreen) {
    final TextTheme textStyles = Theme.of(context).textTheme;

    return SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          //* SLIVER APP BAR
          CustomSliverAppBar(
            opacity: _opacity,
            isLargeScreen: isLargeScreen,
            scrollController: _scrollController,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),

          //* PHRASE
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SelectableText(
                'Welcome to my digital garden 🌱, a space where I cultivate and share my discoveries about developing exceptional products, continually refining myself as a developer, and evolving my career in the vast world of technology.',
                style: textStyles.titleLarge,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: isLargeScreen ? 70 : 40,
            ),
          ),

          //* EXPERIENCE SECTION
          const BoldTitle(
            title: 'Expirience:',
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const TimeLineWidget(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
            ),
          ),

          //* PROJECTS SECTION
          const BoldTitle(
            title: 'Projects:',
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          ProjectList(
            isLargeScreen: isLargeScreen,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
            ),
          ),

          //* TECHNOLOGIES SECTION
          const BoldTitle(
            title: 'Technologies I have worked with:',
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          TechnologiesList(
            wordmark: true,
            onlyWordmark: true,
            isLargeScreen: isLargeScreen,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
            ),
          ),

          //* CONTACT SECTION
          const ContactSection(),

          //* GRACE SPACE
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colors = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
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
                    child: Center(
                      child: Text(
                        '</>',
                        style: TextStyle(
                          fontFamily: GoogleFonts.acme().fontFamily,
                          color: colors.primary,
                          fontSize: 20,
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

  static const Set<Map<String, String>> projects = {
    {
      'name': 'Cotízame',
      'description':
          'In the development of "Cotízame", an innovative mobile application that facilitates interaction between buyers and sellers through direct quotation requests, I lead the creation of the user interface and design, using Flutter. My role is fundamental in the conceptualization and execution of an intuitive user experience, significantly contributing to the distinctive character and usability of the application. This project has been an excellent opportunity to delve deeper into Flutter and Dart, strengthening my skills in interface design and collaboration to deliver a revolutionary market solution.',
      'image': 'assets/cotizame.png',
      'alt': 'Cotízame App Picture',
    },
    {
      'name': 'WikiMovies',
      'description':
          'In the development of "WikiMovies", an innovative mobile application that facilitates interaction between buyers and sellers through direct quotation requests, I lead the creation of the user interface and design, using Flutter.',
      'image': 'assets/wikimovie.png',
      'alt': 'WikiMovies App Picture',
    },
  };

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: isLargeScreen ? 2 : 1,
        childCount: projects.length,
        itemBuilder: (context, index) {
          return ExpandableCard(
            image: projects.elementAt(index)['image']!,
            name: projects.elementAt(index)['name']!,
            description: projects.elementAt(index)['description']!,
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
  });

  final String image;
  final String name;
  final String description;

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = Theme.of(context).textTheme;
    final String shortDescription = widget.description.length > 150
        ? '${widget.description.substring(0, 150)}...'
        : widget.description;
    final String longDescription = widget.description;

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
            Image.asset(
              height: 200,
              width: double.infinity,
              widget.image,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: textStyles.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AnimatedCrossFade(
                    firstChild: Text(shortDescription),
                    secondChild: Text(longDescription),
                    crossFadeState: _showMore
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                    firstCurve: Curves.fastOutSlowIn,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (widget.description.length > 150)
                    Center(
                      child: TextButton(
                        style: const ButtonStyle(
                          enableFeedback: true,
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                          ),
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

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Timeline(
          indicatorColor: colors.primary,
          indicatorSize: 20,
          strokeCap: StrokeCap.round,
          lineGap: 10,
          children: const [
            //* COTIZAME APP
            TimeLineCard(
              proyectName: 'Cotízame',
              role: 'Mobile Developer (Flutter)',
              timelapse: '2023 - Present',
              description:
                  'In the development of "Cotízame", an innovative mobile application that facilitates interaction between buyers and sellers through direct quotation requests, I lead the creation of the user interface and design, using Flutter. My role is fundamental in the conceptualization and execution of an intuitive user experience, significantly contributing to the distinctive character and usability of the application. This project has been an excellent opportunity to delve deeper into Flutter and Dart, strengthening my skills in interface design and collaboration to deliver a revolutionary market solution.',
            ),
            //* FREELANCE
            TimeLineCard(
              proyectName: 'Freelance',
              role: 'Web Developer / Mobile Developer (Ionic, Flutter)',
              timelapse: '2022 - 2023',
              description:
                  'Personal projects and freelance work have been key in expanding development and design skills, facilitating the exploration of innovative solutions independently. These experiences have reinforced the ability to manage projects and solve technical challenges with creativity, without relying on traditional structures.',
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
          color: colors.primary.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            title: Text(
              proyectName,
              style: textStyles.titleMedium,
            ),
            subtitle: Text(
              role,
              style: textStyles.bodySmall!.copyWith(
                color: colors.onSurface.withOpacity(0.6),
              ),
            ),
            trailing: Text(
              timelapse,
              style: textStyles.bodyMedium!.copyWith(
                color: colors.onSurface.withOpacity(0.6),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 10.0,
            ),
            //* SPANISH VERSION
            // child: Text(
            //   'En el desarrollo de "Cotízame", una aplicación móvil innovadora que facilita la interacción entre compradores y vendedores mediante solicitudes de cotización directas, lidero la creación de la interfaz de usuario y el diseño, utilizando Flutter. Mi rol es fundamental en la conceptualización y ejecución de una experiencia de usuario intuitiva, contribuyendo significativamente al carácter distintivo y la usabilidad de la aplicación. Este proyecto ha sido una excelente oportunidad para profundizar en Flutter y Dart, reforzando mis habilidades en diseño de interfaces y colaboración para entregar una solución de mercado revolucionaria.',
            //   style: textStyles.bodyLarge,
            // ),
            //* ENGLISH VERSION
            child: Text(
              description,
              style: textStyles.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required double opacity,
    required this.isLargeScreen,
    required this.scrollController,
  }) : _opacity = opacity;

  final double _opacity;
  final bool isLargeScreen;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    const BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
      bottomLeft: Radius.circular(20),
    );

    //* LIGHT THEME
    final ThemeData appThemeLight = AppTheme(
      isDarkMode: false,
    ).getTheme();

    //* DARK THEME
    final ThemeData appThemeDark = AppTheme(
      isDarkMode: true,
    ).getTheme();

    return SliverAppBar(
      scrolledUnderElevation: 0,
      pinned: true,
      collapsedHeight: 70,
      expandedHeight: isLargeScreen ? 280 : 200.0,
      leading: Opacity(
        opacity: _opacity,
        child: TextButton(
          onPressed: () {},
          child: Text(
            '</>',
            style: TextStyle(
              fontFamily: GoogleFonts.acme().fontFamily,
              fontSize: 20,
            ),
          ),
        ),
      ),
      actions: [
        FilledButton(
          style: const ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
            ),
            enableFeedback: true,
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
            ),
            visualDensity: VisualDensity.comfortable,
          ),
          onPressed: () {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: const Text(
            'Contact',
          ),
        ),
        SizedBox(
          width: isLargeScreen ? 10 : 5,
        ),
        ThemeSwitcher.switcher(
          builder: (context, switcher) {
            return IconButton(
              onPressed: () {
                switcher.changeTheme(
                  isReversed: isDarkMode ? true : false,
                  theme: isDarkMode ? appThemeLight : appThemeDark,
                );
              },
              icon: Icon(
                isDarkMode ? Icons.wb_sunny_rounded : Icons.nights_stay_rounded,
              ),
            );
          },
        ),
        const SizedBox(
          width: 5,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: isLargeScreen ? 2 : 1.5,
        // background: ClipRRect(
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        //     child: Shimmer.fromColors(
        //       period: const Duration(seconds: 3),
        //       baseColor: colors.primary.withOpacity(0.3),
        //       highlightColor: colors.primary.withOpacity(0.9),
        //       enabled: true,
        //       child: Container(
        //         decoration: BoxDecoration(
        //           color: colors.primary.withOpacity(0.1),
        //           borderRadius: BorderRadius.circular(15.0),
        //           border: Border.all(
        //             width: 1.5,
        //             color: colors.primary.withOpacity(0.5),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        titlePadding: const EdgeInsets.all(0),
        title: SliverAppBarTitle(
          isLargeScreen: isLargeScreen,
        ),
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

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          title,
          style: textStyles.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationThickness: 1,
            decorationColor: colors.primary,
            decorationStyle: TextDecorationStyle.wavy,
          ),
        ),
      ),
    );
  }
}

class TechnologiesList extends StatelessWidget {
  const TechnologiesList({
    super.key,
    required this.isLargeScreen,
    this.wordmark = false,
    this.onlyWordmark = false,
  });

  final bool isLargeScreen;
  final bool wordmark;
  final bool onlyWordmark;

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
      'nombre': 'Firebase',
      'icon': DevIcons.firebasePlain,
      'wordmark': DevIcons.firebasePlainWordmark,
      'doc': 'https://firebase.google.com/',
      'alt': 'Firebase Logo',
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
      'nombre': 'Figma',
      'icon': DevIcons.figmaPlain,
      'wordmark': DevIcons.figmaPlain,
      'doc': 'https://www.figma.com/',
      'alt': 'Figma Logo',
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
    {
      'nombre': 'Python',
      'icon': DevIcons.pythonPlain,
      'wordmark': DevIcons.pythonPlainWordmark,
      'doc': 'https://www.python.org/',
      'alt': 'Python Logo',
    },
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
    }
  };

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyles = Theme.of(context).textTheme;
    const double radius = 20;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isLargeScreen ? 5 : 4,
          childAspectRatio: 1 / 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final bool isIconEqualWordmark = techs.elementAt(index)['icon'] ==
                techs.elementAt(index)['wordmark'];

            return AspectRatio(
              aspectRatio: 1,
              child: GestureDetector(
                onTap: () {
                  final Uri url = Uri.parse(techs.elementAt(index)['doc']);

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
                  child: wordmark && !isIconEqualWordmark || onlyWordmark
                      ? Icon(
                          techs.elementAt(index)['wordmark'],
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
                                  techs.elementAt(index)['icon'],
                                  size: isLargeScreen ? 50 : 40,
                                  // color: colors.primary,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                techs.elementAt(index)['nombre'],
                                style: isLargeScreen
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
            );
          },
          childCount: techs.length,
        ),
      ),
    );
  }
}

class SliverAppBarBackground extends StatelessWidget {
  const SliverAppBarBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Image.network(
        'https://d1m75rqqgidzqn.cloudfront.net/wp-data/2020/08/17160042/shutterstock_577183882.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}

class SliverAppBarTitle extends StatelessWidget {
  const SliverAppBarTitle({
    super.key,
    required this.isLargeScreen,
  });

  final bool isLargeScreen;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textStyles = Theme.of(context).textTheme;
    const double radius = 20;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: radius + 6,
              backgroundColor: colors.primary.withOpacity(0.1),
              child: CircleAvatar(
                radius: radius + 3,
                backgroundColor: colors.primary.withOpacity(0.5),
                child: const CircleAvatar(
                  radius: radius,
                  backgroundImage: AssetImage(
                    'assets/portafolio.jpg',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jonathan Simon',
                    style: textStyles.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    isLargeScreen
                        ? 'Software Developer | Tech Enthusiast'
                        : 'Software Developer',
                    style: textStyles.labelSmall!.copyWith(
                      color: colors.onSurface.withOpacity(0.6),
                    ),
                    softWrap: true,
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
