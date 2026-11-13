import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const PortfolioApp());

const ink = Color(0xFF0B0B0C);
const paper = Color(0xFFF4F3EF);
const blue = Color(0xFFA9C7FF);
const muted = Color(0xFF8B8B90);

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muhammad Azlan | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: ink,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: blue, brightness: Brightness.dark),
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'About': GlobalKey(),
    'Skills': GlobalKey(),
    'Projects': GlobalKey(),
    'Experience': GlobalKey(),
    'Contact': GlobalKey(),
  };
  late final AnimationController _heroController;
  late final AnimationController _orbController;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _menuOpen = false;

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..forward();
    _orbController = AnimationController(vsync: this, duration: const Duration(seconds: 7))..repeat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _heroController.dispose();
    _orbController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _goTo(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.04,
      );
    }
    setState(() => _menuOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: GridPainter()),
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: _navigation()),
              SliverToBoxAdapter(child: _hero()),
              SliverToBoxAdapter(child: _about()),
              SliverToBoxAdapter(child: _skills()),
              SliverToBoxAdapter(child: _projects()),
              SliverToBoxAdapter(child: _experience()),
              SliverToBoxAdapter(child: _contact()),
              SliverToBoxAdapter(child: _footer()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navigation() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1240),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          child: LayoutBuilder(builder: (context, constraints) {
            final compact = constraints.maxWidth < 700;
            return Row(
              children: [
                Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(color: paper, borderRadius: BorderRadius.circular(12)),
                  alignment: Alignment.center,
                  child: const Text('A.', style: TextStyle(color: ink, fontWeight: FontWeight.w900, fontSize: 19)),
                ),
                const SizedBox(width: 12),
                const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('AZLAN', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 2.2, fontSize: 12)),
                  Text('FLUTTER DEVELOPER', style: TextStyle(color: muted, letterSpacing: 1.1, fontSize: 9)),
                ]),
                const Spacer(),
                if (!compact) ...[
                  for (final item in _sectionKeys.keys)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        onPressed: () => _goTo(item),
                        child: Text(item, style: const TextStyle(color: Color(0xFFC5C5CA), fontSize: 12)),
                      ),
                    ),
                  const SizedBox(width: 12),
                  _outlineButton('LET’S TALK', () => _goTo('Contact')),
                ] else
                  IconButton(
                    onPressed: () => setState(() => _menuOpen = !_menuOpen),
                    icon: Icon(_menuOpen ? Icons.close : Icons.menu, color: paper),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _hero() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1240),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 68, 24, 105),
          child: LayoutBuilder(builder: (context, c) {
            final narrow = c.maxWidth < 760;
            final copy = FadeTransition(
              opacity: CurvedAnimation(parent: _heroController, curve: Curves.easeOut),
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, .08), end: Offset.zero)
                    .animate(CurvedAnimation(parent: _heroController, curve: Curves.easeOutCubic)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(children: [
                      CircleAvatar(radius: 4, backgroundColor: blue),
                      SizedBox(width: 9),
                      Text('AVAILABLE FOR OPPORTUNITIES', style: TextStyle(color: blue, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w700)),
                    ]),
                    const SizedBox(height: 32),
                    const Text('I BUILD', style: TextStyle(fontSize: 16, letterSpacing: 4, color: muted, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 5),
                    FittedBox(
                      fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
                      child: Text('DIGITAL', style: TextStyle(fontSize: narrow ? 72 : 116, height: .98, fontWeight: FontWeight.w900, letterSpacing: -5)),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown, alignment: Alignment.centerLeft,
                      child: Text('EXPERIENCES.', style: TextStyle(fontSize: narrow ? 48 : 82, height: 1.1, fontWeight: FontWeight.w900, letterSpacing: -3, color: blue)),
                    ),
                    const SizedBox(height: 24),
                      ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 490),
                      child: Text(
                        'I’m Muhammad Azlan — a Flutter developer crafting thoughtful mobile experiences with clean interfaces, purposeful motion, and attention to detail.',
                        style: TextStyle(color: Color(0xFFB2B2B8), fontSize: 15, height: 1.9),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(spacing: 12, runSpacing: 12, children: [
                      _primaryButton('EXPLORE MY WORK', () => _goTo('Projects'), icon: Icons.arrow_downward_rounded),
                      _outlineButton('GET IN TOUCH', () => _goTo('Contact')),
                    ]),
                    const SizedBox(height: 48),
                    const Row(children: [
                      _TinyStat(value: '01+', label: 'YEARS LEARNING'),
                      SizedBox(width: 30),
                      _TinyStat(value: '05+', label: 'PRACTICE PROJECTS'),
                      SizedBox(width: 30),
                      _TinyStat(value: '100%', label: 'CURIOSITY'),
                    ]),
                  ],
                ),
              ),
            );
            final visual = AnimatedBuilder(
              animation: _orbController,
              builder: (context, _) {
                final rotation = _orbController.value * 6.28318;
                return SizedBox(
                  height: narrow ? 300 : 480,
                  child: Stack(alignment: Alignment.center, children: [
                    Transform.rotate(
                      angle: rotation * .3,
                      child: Container(
                        width: narrow ? 240 : 360, height: narrow ? 240 : 360,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF34343A), width: 1),
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: blue, shape: BoxShape.circle, boxShadow: [BoxShadow(color: blue, blurRadius: 18)])),
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: -rotation * .55,
                      child: Container(
                        width: narrow ? 180 : 275, height: narrow ? 180 : 275,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF25252A), width: 1),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(width: 7, height: 7, decoration: const BoxDecoration(color: Color(0xFFEDEBE5), shape: BoxShape.circle)),
                        ),
                      ),
                    ),
                    Container(
                      width: narrow ? 130 : 205, height: narrow ? 130 : 205,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(colors: [blue.withOpacity(.25), const Color(0xFF5C76A6).withOpacity(.13), ink]),
                        boxShadow: [BoxShadow(color: blue.withOpacity(.09 + .07 * (1 + (rotation % 3.14) / 3.14)), blurRadius: 75, spreadRadius: 10)],
                      ),
                      child: const Center(child: Icon(Icons.all_inclusive_rounded, color: blue, size: 66)),
                    ),
                    Positioned(
                      bottom: 22, right: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        decoration: BoxDecoration(color: const Color(0xFF171719), border: Border.all(color: const Color(0xFF303035)), borderRadius: BorderRadius.circular(14)),
                        child: const Row(children: [
                          Icon(Icons.code_rounded, color: blue, size: 17),
                          SizedBox(width: 9),
                          Text('Flutter • Dart', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                        ]),
                      ),
                    ),
                    Positioned(
                      top: 38, left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                        decoration: BoxDecoration(color: const Color(0xFF171719), border: Border.all(color: const Color(0xFF303035)), borderRadius: BorderRadius.circular(12)),
                        child: const Row(children: [
                          Icon(Icons.auto_awesome, color: blue, size: 15),
                          SizedBox(width: 8),
                          Text('UI / UX FOCUSED', style: TextStyle(fontSize: 9, letterSpacing: 1.1)),
                        ]),
                      ),
                    ),
                  ]),
                );
              },
            );
            return narrow
                ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [copy, const SizedBox(height: 24), visual])
                : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Expanded(flex: 6, child: copy),
                    Expanded(flex: 5, child: visual),
                  ]);
          }),
        ),
      ),
    );
  }

  Widget _about() {
    return _section(
      key: _sectionKeys['About'],
      eyebrow: 'A LITTLE ABOUT ME',
      title: 'Curious by nature.\\nDeveloper by choice.',
      child: LayoutBuilder(builder: (context, c) {
        final narrow = c.maxWidth < 720;
        final intro = const Text(
          'I enjoy turning ideas into clean, intuitive mobile applications. My focus is Flutter front-end development: building responsive layouts, reusable widgets, and interfaces that feel natural to use.',
          style: TextStyle(color: Color(0xFFB8B8BD), fontSize: 15, height: 1.9),
        );
        final details = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _detailLine(Icons.school_outlined, 'EDUCATION', 'BS Information Technology'),
          const SizedBox(height: 18),
          _detailLine(Icons.devices_outlined, 'FOCUS', 'Flutter · Dart · Mobile UI'),
          const SizedBox(height: 18),
          _detailLine(Icons.location_on_outlined, 'BASED IN', 'Pakistan · Open to remote work'),
        ]);
        return narrow ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [intro, const SizedBox(height: 30), details]) : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: intro), const SizedBox(width: 80), Expanded(child: details)]);
      }),
    );
  }

  Widget _skills() {
    final skills = [
      ('Flutter', 'Cross-platform UI', .88),
      ('Dart', 'Language & OOP', .82),
      ('Responsive UI', 'Layouts & widgets', .90),
      ('REST APIs', 'HTTP & JSON basics', .62),
      ('Firebase', 'Learning & integration', .48),
      ('Git / GitHub', 'Version control', .58),
    ];
    return _section(
      key: _sectionKeys['Skills'],
      eyebrow: 'THE TOOLKIT',
      title: 'Skills that bring\\nideas to life.',
      child: LayoutBuilder(builder: (context, c) {
        final columns = c.maxWidth < 600 ? 1 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: skills.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns, crossAxisSpacing: 28, mainAxisSpacing: 28,
            mainAxisExtent: 104,
          ),
          itemBuilder: (context, i) {
            final s = skills[i];
            return _SkillTile(title: s.$1, subtitle: s.$2, value: s.$3, index: i);
          },
        );
      }),
    );
  }

  Widget _projects() {
    final projects = [
      ('01', 'School Management App', 'FLUTTER · DASHBOARDS', 'A school-focused interface for students, attendance, daily diary, teacher reports, and salary records.', Icons.school_outlined),
      ('02', 'Islamic Companion', 'FLUTTER · API INTEGRATION', 'A calm, green-themed concept for Quran reading, prayer times, tasbeeh, duas, and daily worship tools.', Icons.mosque_outlined),
      ('03', 'Tech Store', 'FLUTTER · PHP / MYSQL', 'An e-commerce practice project exploring product categories, favourites, cart management, and checkout flows.', Icons.shopping_bag_outlined),
    ];
    return _section(
      key: _sectionKeys['Projects'],
      eyebrow: 'SELECTED WORK',
      title: 'A few things I’ve\\nbeen building.',
      trailing: 'PROJECTS / 03',
      child: Column(children: [
        for (var i = 0; i < projects.length; i++) ...[
          _ProjectCard(number: projects[i].$1, title: projects[i].$2, category: projects[i].$3, description: projects[i].$4, icon: projects[i].$5),
          if (i != projects.length - 1) const SizedBox(height: 14),
        ],
      ]),
    );
  }

  Widget _experience() {
    return _section(
      key: _sectionKeys['Experience'],
      eyebrow: 'THE JOURNEY',
      title: 'Learning. Building.\\nGetting better.',
      child: Column(children: [
        _timelineItem('2026 — NOW', 'Flutter Developer', 'Independent learning & portfolio projects', 'Building practical Flutter applications, strengthening Dart and OOP fundamentals, and learning API integration.'),
        _timelineItem('2022 — 2026', 'BS Information Technology', 'University of Sahiwal', 'Completed a foundation in information technology and developed an interest in mobile application development.'),
        _timelineItem('CURRENT', 'Computer Operator', 'School environment', 'Supporting day-to-day computer-based school operations while preparing for a dedicated Flutter development role.'),
      ]),
    );
  }

  Widget _contact() {
    return _section(
      key: _sectionKeys['Contact'],
      eyebrow: 'HAVE A PROJECT IN MIND?',
      title: 'Let’s make\\nsomething useful.',
      child: LayoutBuilder(builder: (context, c) {
        final narrow = c.maxWidth < 760;
        final details = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Have an internship opportunity, a collaboration idea, or a project you would like to discuss? Send a message and let’s start a conversation.', style: TextStyle(color: Color(0xFFB8B8BD), height: 1.9, fontSize: 14)),
          const SizedBox(height: 28),
          _contactDetail(Icons.mail_outline, 'EMAIL', 'azlan@example.com'),
          const SizedBox(height: 15),
          _contactDetail(Icons.location_on_outlined, 'LOCATION', 'Pakistan · Available remotely'),
          const SizedBox(height: 20),
          const Text('Replace the sample email with your real contact address before publishing.', style: TextStyle(color: muted, fontSize: 11, height: 1.6)),
        ]);
        final form = Column(children: [
          _formField(_nameController, 'Your name'),
          const SizedBox(height: 12),
          _formField(_emailController, 'Email address', email: true),
          const SizedBox(height: 12),
          _formField(_messageController, 'Tell me about your project', multiline: true),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: _primaryButton('PREPARE MESSAGE', _submitContact, icon: Icons.arrow_outward_rounded)),
        ]);
        return narrow ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [details, const SizedBox(height: 36), form]) : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: details), const SizedBox(width: 70), Expanded(child: form)]);
      }),
    );
  }

  void _submitContact() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();
    if (name.isEmpty || email.isEmpty || message.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your name, a valid email, and a message.')));
      return;
    }
    final body = 'Name: $name\\nEmail: $email\\n\\n$message';
    Clipboard.setData(ClipboardData(text: body));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message copied! Paste it into your email app to send.')));
  }

  Widget _footer() {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFF28282D)))),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
            child: LayoutBuilder(builder: (context, c) {
              final narrow = c.maxWidth < 600;
              final copyright = const Text('© 2026 MUHAMMAD AZLAN. MADE WITH FLUTTER.', style: TextStyle(color: muted, fontSize: 9, letterSpacing: 1.2));
              final made = const Row(mainAxisSize: MainAxisSize.min, children: [
                Text('DESIGNED WITH INTENTION', style: TextStyle(color: muted, fontSize: 9, letterSpacing: 1.1)),
                SizedBox(width: 8),
                Icon(Icons.favorite, color: blue, size: 12),
              ]);
              return narrow ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [copyright, const SizedBox(height: 12), made]) : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [copyright, made]);
            }),
          ),
        ),
      ),
    );
  }

  Widget _section({GlobalKey? key, required String eyebrow, required String title, required Widget child, String? trailing}) {
    return Container(
      key: key,
      width: double.infinity,
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFF252529)))),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 92),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 22, height: 2, color: blue),
                const SizedBox(width: 10),
                Text(eyebrow, style: const TextStyle(color: blue, fontSize: 10, letterSpacing: 2.1, fontWeight: FontWeight.w700)),
                const Spacer(),
                if (trailing != null) Text(trailing, style: const TextStyle(color: muted, fontSize: 9, letterSpacing: 1.2)),
              ]),
              const SizedBox(height: 24),
              Text(title.replaceAll(r'\n', '\n'), style: const TextStyle(fontSize: 42, height: 1.12, letterSpacing: -1.8, fontWeight: FontWeight.w800)),
              const SizedBox(height: 38),
              child,
            ]),
          ),
        ),
      ),
    );
  }

  Widget _detailLine(IconData icon, String label, String value) => Row(children: [
    Container(width: 42, height: 42, decoration: BoxDecoration(border: Border.all(color: const Color(0xFF35353B)), borderRadius: BorderRadius.circular(12)), child: Icon(icon, size: 18, color: blue)),
    const SizedBox(width: 14),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: muted, fontSize: 9, letterSpacing: 1.4)),
      const SizedBox(height: 5),
      Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
    ])),
  ]);

  Widget _timelineItem(String date, String title, String place, String detail) => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 110, child: Padding(padding: const EdgeInsets.only(top: 4), child: Text(date, style: const TextStyle(color: blue, fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.w700)))),
      Container(width: 9, height: 9, margin: const EdgeInsets.only(top: 5), decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(3), boxShadow: [BoxShadow(color: blue.withOpacity(.3), blurRadius: 9)])),
      const SizedBox(width: 22),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(place, style: const TextStyle(color: muted, fontSize: 12)),
        const SizedBox(height: 12),
        Text(detail, style: const TextStyle(color: Color(0xFFB8B8BD), fontSize: 13, height: 1.8)),
      ])),
    ]),
  );

  Widget _contactDetail(IconData icon, String label, String value) => Row(children: [
    Icon(icon, color: blue, size: 17), const SizedBox(width: 12),
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: muted, fontSize: 9, letterSpacing: 1.2)),
      const SizedBox(height: 4),
      Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
    ]),
  ]);

  Widget _formField(TextEditingController controller, String hint, {bool multiline = false, bool email = false}) => TextField(
    controller: controller,
    keyboardType: email ? TextInputType.emailAddress : (multiline ? TextInputType.multiline : TextInputType.text),
    maxLines: multiline ? 5 : 1,
    style: const TextStyle(color: paper, fontSize: 13),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF77777D), fontSize: 12),
      filled: true, fillColor: const Color(0xFF121214),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2C2C31))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: blue)),
    ),
  );

  Widget _primaryButton(String label, VoidCallback onPressed, {IconData? icon}) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: paper, foregroundColor: ink, elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Text(label, style: const TextStyle(fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.w800)),
      if (icon != null) ...[const SizedBox(width: 12), Icon(icon, size: 15)],
    ]),
  );

  Widget _outlineButton(String label, VoidCallback onPressed) => OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      foregroundColor: paper, side: const BorderSide(color: Color(0xFF424248)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
    ),
    child: Text(label, style: const TextStyle(fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.w700)),
  );
}

class _TinyStat extends StatelessWidget {
  final String value;
  final String label;
  const _TinyStat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: paper)),
    const SizedBox(height: 5),
    Text(label, style: const TextStyle(fontSize: 8, color: muted, letterSpacing: 1.0)),
  ]);
}

class _SkillTile extends StatefulWidget {
  final String title, subtitle;
  final double value;
  final int index;
  const _SkillTile({required this.title, required this.subtitle, required this.value, required this.index});
  @override
  State<_SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<_SkillTile> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _hovered = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 700 + widget.index * 100));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    Future.delayed(Duration(milliseconds: 180 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _hovered ? const Color(0xFF171719) : const Color(0xFF101012),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _hovered ? const Color(0xFF5A6D8F) : const Color(0xFF29292E)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14))),
          Text('${(widget.value * 100).round()}%', style: const TextStyle(color: blue, fontSize: 11, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 5),
        Text(widget.subtitle, style: const TextStyle(color: muted, fontSize: 10)),
        const Spacer(),
        AnimatedBuilder(animation: _animation, builder: (context, _) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(value: widget.value * _animation.value, minHeight: 3, backgroundColor: const Color(0xFF2A2A30), valueColor: const AlwaysStoppedAnimation(blue)),
        )),
      ]),
    ),
  );
}

class _ProjectCard extends StatefulWidget {
  final String number, title, category, description;
  final IconData icon;
  const _ProjectCard({required this.number, required this.title, required this.category, required this.description, required this.icon});
  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _hovered ? const Color(0xFF171719) : const Color(0xFF101012),
        border: Border.all(color: _hovered ? const Color(0xFF65799C) : const Color(0xFF29292E)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: LayoutBuilder(builder: (context, c) {
        final narrow = c.maxWidth < 570;
        final leading = Container(
          width: 62, height: 62,
          decoration: BoxDecoration(color: const Color(0xFF1B1D22), borderRadius: BorderRadius.circular(16)),
          child: Icon(widget.icon, color: blue, size: 27),
        );
        final content = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${widget.number}  /  ${widget.category}', style: const TextStyle(color: blue, fontSize: 9, letterSpacing: 1.3, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text(widget.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -.4)),
          const SizedBox(height: 9),
          Text(widget.description, style: const TextStyle(color: Color(0xFFB0B0B6), fontSize: 12, height: 1.8)),
        ]);
        return narrow ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [leading, const SizedBox(height: 20), content, const SizedBox(height: 16), _viewButton(context)]) : Row(children: [
          leading, const SizedBox(width: 24), Expanded(child: content), const SizedBox(width: 20), _viewButton(context),
        ]);
      }),
    ),
  );

  Widget _viewButton(BuildContext context) => IconButton(
    tooltip: 'Project details',
    onPressed: () => showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF171719),
      title: Text(widget.title),
      content: Text('${widget.description}\\n\\nThis is a portfolio project showcase. Add your screenshots, GitHub repository, and live demo URL here when available.', style: const TextStyle(height: 1.6, color: Color(0xFFB8B8BD))),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('CLOSE'))],
    )),
    icon: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 42, height: 42,
      decoration: BoxDecoration(color: _hovered ? blue : Colors.transparent, shape: BoxShape.circle, border: Border.all(color: _hovered ? blue : const Color(0xFF45454B))),
      child: Icon(Icons.arrow_outward_rounded, color: _hovered ? ink : paper, size: 18),
    ),
  );
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF151518)..strokeWidth = .6;
    const step = 52.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    final glowPaint = Paint()
      ..shader = RadialGradient(colors: [blue.withOpacity(.045), Colors.transparent]).createShader(Rect.fromCircle(center: Offset(size.width * .78, 260), radius: 430));
    canvas.drawRect(Offset.zero & size, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
