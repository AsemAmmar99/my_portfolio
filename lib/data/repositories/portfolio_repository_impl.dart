import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/skill_category_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';

/// Static data repository — seeded from Asem's CV, LinkedIn, and GitHub
class PortfolioRepositoryImpl implements PortfolioRepository {
  @override
  Future<List<ProjectEntity>> getProjects() async {
    // Simulate async data loading
    await Future.delayed(const Duration(milliseconds: 300));
    return _projects;
  }

  @override
  Future<List<ExperienceEntity>> getExperience() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _experience;
  }

  @override
  Future<List<SkillCategoryEntity>> getSkillCategories() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _skillCategories;
  }

  // ── Projects Data ─────────────────────────────────────────────────────────
  static const List<ProjectEntity> _projects = [
    ProjectEntity(
      id: 'elkheta',
      name: 'Elkheta — التعليم الذكي',
      description:
          'Innovative educational platform for students across Egypt and the Arab world. '
          'Built and maintained multiple feature modules with high performance. '
          'Integrated deep linking, FCM notifications, and offline caching.',
      techStack: ['Flutter', 'BLoC', 'Clean Architecture', 'GraphQL', 'Firebase', 'FCM'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.elkheta',
      category: 'flutter',
      isFeatured: true,
    ),
    ProjectEntity(
      id: 'benefex',
      name: 'BenefEx — Employee Benefits',
      description:
          'Corporate benefits and promotions platform connecting employees with '
          'exclusive offers. Features secure authentication, push notifications, '
          'and a rich browsable catalog of company perks.',
      techStack: ['Flutter', 'BLoC', 'REST API', 'Firebase Auth', 'GetIt'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.bluecrunch.benefex',
      appStoreUrl: 'https://apps.apple.com/eg/app/benefex/id1394248863',
      category: 'flutter',
      isFeatured: true,
    ),
    ProjectEntity(
      id: 'emart',
      name: 'eMart — B2B Marketplace',
      description:
          'A B2B marketplace connecting micro, small and medium enterprises at '
          'scale. Owned full SDK upgrade migration and performance optimization '
          'including code refactoring for Clean Architecture compliance.',
      techStack: ['Flutter', 'Kotlin', 'BLoC', 'Firebase', 'Crashlytics', 'CI/CD'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.emart.shop',
      appStoreUrl: 'https://apps.apple.com/om/app/emart/id1614692611',
      category: 'flutter',
      isFeatured: true,
    ),
    ProjectEntity(
      id: 'hpadel',
      name: 'HPadel — Court Booking',
      description:
          'Padel court reservation app with real-time slot availability, '
          'in-app payments, and court location mapping. Published across '
          'Google Play and App Store.',
      techStack: ['Flutter', 'BLoC', 'Google Maps', 'Payment SDK', 'Dio'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.apessmartsolutions.hpadelapp',
      appStoreUrl: 'https://apps.apple.com/eg/app/hpadel/id6450797965',
      category: 'flutter',
      isFeatured: false,
    ),
    ProjectEntity(
      id: 'geview',
      name: 'GeView — GSK Healthcare',
      description:
          'Professional healthcare app for GSK Gulf region. Designed exclusively '
          'for healthcare professionals with secure content access, analytics, '
          'and offline document viewing.',
      techStack: ['Flutter', 'Clean Architecture', 'BLoC', 'Dio', 'Firebase Analytics'],
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.gsk.GSKProGulf',
      appStoreUrl: 'https://apps.apple.com/be/app/geview/id1643973949',
      category: 'flutter',
      isFeatured: false,
    ),
    ProjectEntity(
      id: 'weather_app',
      name: 'Weather Forecast App',
      description:
          'Complex data visualization with real-time weather charts, '
          'interactive maps, and location-based forecasting. Showcases '
          'advanced BLoC patterns and Syncfusion Charts integration.',
      techStack: ['Flutter', 'BLoC', 'Dio', 'Syncfusion Charts', 'Google Maps', 'Geolocator'],
      githubUrl: 'https://github.com/AsemAmmar99/weather_app',
      category: 'opensource',
      isFeatured: false,
    ),
    ProjectEntity(
      id: 'hotel_booking',
      name: 'Hotel Booking App',
      description:
          'End-to-end hotel booking flow with dependency injection, '
          'custom responsive layouts, and Google Maps integration. '
          'Demonstrates enterprise-grade Flutter patterns.',
      techStack: ['Flutter', 'BLoC', 'GetIt', 'Dio', 'Sizer', 'Google Maps'],
      githubUrl: 'https://github.com/AsemAmmar99/hotel_booking_app',
      category: 'opensource',
      isFeatured: false,
    ),
    ProjectEntity(
      id: 'chat_service',
      name: 'Chat Service App',
      description:
          'Real-time messaging application with Firebase Authentication, '
          'Firestore cloud database, and live message streaming. '
          'A full-featured social chat experience.',
      techStack: ['Flutter', 'Firebase Auth', 'Firestore', 'FCM'],
      githubUrl: 'https://github.com/AsemAmmar99/chat_service_app',
      category: 'opensource',
      isFeatured: false,
    ),
  ];

  // ── Experience Data ───────────────────────────────────────────────────────
  static const List<ExperienceEntity> _experience = [
    ExperienceEntity(
      id: 'elkheta',
      company: 'Elkheta — الخطة',
      role: 'Senior Flutter Developer',
      period: 'Aug 2024 – Present',
      location: 'Alexandria, Egypt',
      isCurrent: true,
      bullets: [
        'Create and develop multiple feature modules of Elkheta\'s official educational mobile app.',
        'Ensure best-in-class performance, quality, and responsiveness across all modules.',
        'Collaborate closely with product managers and UI/UX designers to deliver high-quality features.',
        'Maintain code quality, architecture standards, and documentation for a large codebase.',
      ],
    ),
    ExperienceEntity(
      id: 'mentech',
      company: 'MENT\'ECH',
      role: 'Senior Software Engineer',
      period: 'Mar 2023 – Mar 2026',
      location: 'Maadi, Cairo, Egypt',
      isCurrent: false,
      bullets: [
        'Ensured best-in-class performance, quality, and responsiveness across multiple applications.',
        'Led SDK migration — upgraded legacy Flutter SDKs to latest versions with zero downtime.',
        'Maintained code quality, organization, and automated testing pipelines.',
        'Refactored critical modules for Clean Architecture compliance.',
        'Collaborated with product managers and UI/UX designers to deliver high-quality mobile features.',
      ],
    ),
    ExperienceEntity(
      id: 'apes',
      company: 'Apes Solutions',
      role: 'Flutter Developer',
      period: 'Sep 2023 – Jun 2024',
      location: 'Remote — Part-time',
      bullets: [
        'Developed mobile apps for diverse clients using Flutter with Riverpod state management.',
        'Shipped GeView (GSK Gulf healthcare app) to Google Play and App Store.',
        'Built HPadel (court booking) and Tamreena (fitness) — both live on major stores.',
        'Worked in Agile sprints with Jira and cross-functional international teams.',
      ],
    ),
    ExperienceEntity(
      id: 'amit',
      company: 'AMIT Learning',
      role: 'Flutter Instructor',
      period: 'Aug 2022 – Jun 2023',
      location: 'Maadi, Cairo, Egypt',
      bullets: [
        'Taught Mobile Programming diplomas using Dart and the Flutter framework.',
        'Guided +50 students from zero to shipping their first mobile apps.',
        'Designed hands-on curriculum covering BLoC, Clean Architecture, and Firebase integrations.',
      ],
    ),
    ExperienceEntity(
      id: 'algoriza',
      company: 'Algoriza',
      role: 'Junior Flutter Developer → Intern',
      period: 'Jun 2022 – Jan 2023',
      location: 'Elsheikh Zayed, Egypt',
      bullets: [
        'Progressed from intern to Junior Flutter Developer within the same organization.',
        'Maintained code quality and upgraded legacy applications to modern standards.',
        'Contributed to production features under senior mentorship.',
        'Delivered responsive, performant UI components across multiple client projects.',
      ],
    ),
    ExperienceEntity(
      id: 'magdsoft',
      company: 'Magdsoft',
      role: 'Junior Android & Flutter Developer',
      period: 'Dec 2021 – Jun 2022',
      location: 'Nasr City, Cairo, Egypt',
      bullets: [
        'Developed and maintained modules for Android (Kotlin) and Flutter cross-platform apps.',
        'Shipped Shobeek — a full-featured e-commerce/service platform app.',
        'Ensured best-possible performance, quality, and responsiveness of various app modules.',
        'Collaborated in Agile sprints using Jira and Azure DevOps.',
      ],
    ),
    ExperienceEntity(
      id: 'freelance',
      company: 'Self-Employed',
      role: 'Freelance Android Developer',
      period: 'Dec 2019 – Nov 2021',
      location: 'Cairo, Egypt',
      bullets: [
        'Built native Android applications for various clients from scratch to Play Store launch.',
        'Developed Hn2olk — an open-source Android project (available on GitHub).',
        'Gained deep fundamentals in Android SDK, Kotlin, and app store deployment.',
      ],
    ),
  ];

  // ── Skills Data ───────────────────────────────────────────────────────────
  static const List<SkillCategoryEntity> _skillCategories = [
    SkillCategoryEntity(
      id: 'flutter',
      categoryName: 'Flutter & Dart',
      icon: '📱',
      accentColor: '#00B4D8',
      skills: [
        SkillItem(name: 'Flutter', proficiency: 0.95),
        SkillItem(name: 'Dart', proficiency: 0.95),
        SkillItem(name: 'BLoC / Cubit', proficiency: 0.92),
        SkillItem(name: 'Clean Architecture', proficiency: 0.90),
        SkillItem(name: 'Dio / Retrofit', proficiency: 0.88),
        SkillItem(name: 'GetIt (DI)', proficiency: 0.85),
        SkillItem(name: 'Flutter Web', proficiency: 0.80),
        SkillItem(name: 'Animations', proficiency: 0.85),
      ],
    ),
    SkillCategoryEntity(
      id: 'android',
      categoryName: 'Native Android',
      icon: '🤖',
      accentColor: '#3DDC84',
      skills: [
        SkillItem(name: 'Kotlin', proficiency: 0.85),
        SkillItem(name: 'Android SDK', proficiency: 0.80),
        SkillItem(name: 'Jetpack Compose', proficiency: 0.70),
        SkillItem(name: 'MVVM / MVI', proficiency: 0.82),
        SkillItem(name: 'Room / SQLite', proficiency: 0.78),
        SkillItem(name: 'RxJava / Coroutines', proficiency: 0.75),
      ],
    ),
    SkillCategoryEntity(
      id: 'backend',
      categoryName: 'Firebase & Backend',
      icon: '🔥',
      accentColor: '#FFA000',
      skills: [
        SkillItem(name: 'Firebase Auth', proficiency: 0.90),
        SkillItem(name: 'Firestore', proficiency: 0.85),
        SkillItem(name: 'FCM (Push)', proficiency: 0.88),
        SkillItem(name: 'Crashlytics', proficiency: 0.85),
        SkillItem(name: 'Firebase Analytics', proficiency: 0.80),
        SkillItem(name: 'REST APIs', proficiency: 0.92),
        SkillItem(name: 'GraphQL', proficiency: 0.72),
      ],
    ),
    SkillCategoryEntity(
      id: 'devops',
      categoryName: 'Architecture & DevOps',
      icon: '⚙️',
      accentColor: '#9B59B6',
      skills: [
        SkillItem(name: 'Git / GitHub', proficiency: 0.92),
        SkillItem(name: 'CI/CD (GitLab/Azure)', proficiency: 0.80),
        SkillItem(name: 'SOLID Principles', proficiency: 0.90),
        SkillItem(name: 'Unit Testing', proficiency: 0.82),
        SkillItem(name: 'Agile / Scrum', proficiency: 0.88),
        SkillItem(name: 'Play Store / App Store', proficiency: 0.85),
      ],
    ),
  ];
}
