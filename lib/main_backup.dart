// ============================================================
//  AnubhavX – World Tourism & VR Experiences
//  Full Production Code  |  v4.1  |  Netflix-Level Build
//  © 2025 AnubhavX Technologies Pvt. Ltd.
// ============================================================
//
//  pubspec.yaml dependencies:
//    flutter:
//      sdk: flutter
//    google_fonts: ^6.1.0
//    shared_preferences: ^2.2.2
//    url_launcher: ^6.2.5
//    android_intent_plus: ^4.0.3
//    flutter_unity_widget: ^2022.2.1
//
//  AndroidManifest.xml – add inside <manifest>:
//    <queries>
//      <package android:name="com.anubhavx.temple" />
//    </queries>
//    <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>
//
//  assets/temple.apk  →  place your Unity APK here
//  assets/logo.png    →  your app logo
// ============================================================

import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'subscription_screen.dart';// ─────────────────────────────────────────────────────────────
//  ENTRY POINT
// ─────────────────────────────────────────────────────────────

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF03030A),
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const AnubhavXApp());
}

// ─────────────────────────────────────────────────────────────
//  COLOR PALETTE
// ─────────────────────────────────────────────────────────────
class C {
  static const bg         = Color(0xFF03030A);
  static const bgDeep     = Color(0xFF060612);
  static const surface    = Color(0xFF0B0B1C);
  static const card       = Color(0xFF0F0F24);
  static const cardBorder = Color(0xFF1C1C3A);

  static const gold       = Color(0xFFE8B84B);
  static const goldDark   = Color(0xFFC49A2A);
  static const goldLight  = Color(0xFFF5D678);

  static const saffron    = Color(0xFFFF6B35);
  static const ember      = Color(0xFFFF3C00);

  static const teal       = Color(0xFF00D4BB);
  static const tealDark   = Color(0xFF009E8A);
  static const tealLight  = Color(0xFF5FFFF0);

  static const violet     = Color(0xFF7B35FF);
  static const violetDark = Color(0xFF4A1A99);
  static const violetLight= Color(0xFFA87BFF);

  static const royal      = Color(0xFF1A6FFF);
  static const royalDark  = Color(0xFF0A4ABB);
  static const royalLight = Color(0xFF6AACFF);

  static const coral      = Color(0xFFFF4F7B);

  static const white      = Color(0xFFF2EEE8);
  static const white80    = Color(0xCCF2EEE8);
  static const white60    = Color(0x99F2EEE8);
  static const white40    = Color(0x66F2EEE8);
  static const white20    = Color(0x33F2EEE8);
  static const white10    = Color(0x1AF2EEE8);
  static const white06    = Color(0x0FF2EEE8);
  static const trialC     = Color(0xFF00E5FF);
  static const bgCard     = Color(0xFF15112E);

  static const purple      = Color(0xFF7C3AED);
  static const purpleLight = Color(0xFFA78BFA);
  static const blue        = Color(0xFF3B82F6);
  static const blueLight   = Color(0xFF60A5FA);
  static const white15     = Color(0x26FFFFFF);
  static const white25     = Color(0x40FFFFFF);

  static const LinearGradient fireGrad = LinearGradient(
    colors: [gold, saffron, ember],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient tealGrad = LinearGradient(
    colors: [teal, tealDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient violetGrad = LinearGradient(
    colors: [violet, violetDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient royalGrad = LinearGradient(
    colors: [royal, royalDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ═══════════════════════════════════════════════════════════════
//  TYPOGRAPHY
// ═══════════════════════════════════════════════════════════════
TextStyle cinzel({
  double size = 14,
  Color color = C.white,
  FontWeight weight = FontWeight.w600,
  double spacing = 0,
}) => GoogleFonts.cinzel(
    fontSize: size, color: color, fontWeight: weight, letterSpacing: spacing);

TextStyle lato({
  double size = 13,
  Color color = C.white60,
  FontWeight weight = FontWeight.w400,
  double height = 1.4,
}) => GoogleFonts.lato(
    fontSize: size, color: color, fontWeight: weight, height: height);

TextStyle cormorant({
  double size = 14,
  Color color = C.gold,
  FontWeight weight = FontWeight.w600,
  double spacing = 0.5,
}) => GoogleFonts.cormorantGaramond(
    fontSize: size, color: color, fontWeight: weight, letterSpacing: spacing);

// ─────────────────────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────────────────────

class DestinationModel {
  final String name;
  final String country;
  final String region;
  final String description;
  final String category;
  final String bestTime;
  final String significance;
  final String iconEmoji;
  final Color accentColor;
  final List<String> tags;
  final bool hasVR;
  final bool isTemple;

  const DestinationModel({
    required this.name,
    required this.country,
    required this.region,
    required this.description,
    required this.category,
    required this.bestTime,
    required this.significance,
    this.iconEmoji = '🌏',
    this.accentColor = C.gold,
    this.tags = const [],
    this.hasVR = false,
    this.isTemple = false,
  });
}

class PlanModel {
  final String id;
  final String name;
  final String emoji;
  final int price;
  final int? vrPrice;
  final int trialDays;
  final List<String> features;
  final String tagline;
  final String badge;
  final Color color;
  final Color colorDark;
  final bool isPopular;
  final bool comingSoon;

  const PlanModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.price,
    this.vrPrice,
    this.trialDays = 0,
    required this.features,
    required this.tagline,
    required this.badge,
    required this.color,
    required this.colorDark,
    this.isPopular = false,
    this.comingSoon = false,
  });
}

// ─────────────────────────────────────────────────────────────
//  DESTINATION DATA
// ─────────────────────────────────────────────────────────────

class DestinationData {
  static const List<DestinationModel> jammuTemples = [
    DestinationModel(
      name: "Raghunath Temple",
      country: "India", region: "Jammu", category: "Temple",
      iconEmoji: "🛕", accentColor: C.gold,
      description: "One of the largest temple complexes of North India, dedicated to Lord Rama. Built by Maharaja Gulab Singh in 1835. The main shrine is covered with gold sheets.",
      bestTime: "Oct – Mar",
      significance: "Gold-plated interiors, 300+ sacred Shaligrams, and 7 stunning shrine rooms.",
      tags: ["Vaishnavite", "Historic", "Gold Plated"], hasVR: true, isTemple: true,
    ),
    DestinationModel(
      name: "Ranbireshwar Temple",
      country: "India", region: "Jammu", category: "Temple",
      iconEmoji: "🔱", accentColor: C.teal,
      description: "A magnificent Shiva temple housing the tallest Shiva Lingam in North India — 7.5 feet tall. Built by Maharaja Ranbir Singh in 1883.",
      bestTime: "Maha Shivratri",
      significance: "12 crystal Shiva Lingams and towering Sphatik Shivling.",
      tags: ["Shaivite", "Crystal Lingam", "Historic"], hasVR: true, isTemple: true,
    ),
    DestinationModel(
      name: "Peer Kho Cave Temple",
      country: "India", region: "Jammu", category: "Temple",
      iconEmoji: "🪨", accentColor: C.teal,
      description: "Ancient natural cave temple carved into rocky hills along the Tawi River with naturally formed Shiva Lingam.",
      bestTime: "Year Round",
      significance: "Thousands of years old cave with immense spiritual energy.",
      tags: ["Cave Temple", "Ancient", "Shaivite"], hasVR: true, isTemple: true,
    ),
    DestinationModel(
      name: "Bahu Fort Kali Temple",
      country: "India", region: "Jammu", category: "Temple",
      iconEmoji: "⚔️", accentColor: C.saffron,
      description: "Ancient temple inside the historic Bahu Fort with panoramic views of the Tawi River. Most powerful Shakti peetha in Jammu.",
      bestTime: "Navratri",
      significance: "3000-year-old fort. Lakhs visit during Navratri.",
      tags: ["Shakti", "Fort Temple", "Must Visit"], hasVR: true, isTemple: true,
    ),
    DestinationModel(
      name: "Vaishno Devi",
      country: "India", region: "Katra, Jammu", category: "Temple",
      iconEmoji: "🏔", accentColor: C.saffron,
      description: "The most sacred pilgrimage in North India at 5200 ft in the Trikuta Mountains. Over 8 million pilgrims annually.",
      bestTime: "Mar – Jun, Sep – Nov",
      significance: "Shakti Peetha with three natural rock Pindis.",
      tags: ["Shakti Peetha", "Must Visit", "National"], hasVR: true, isTemple: true,
    ),
    DestinationModel(
      name: "Mahamaya Temple",
      country: "India", region: "Jammu", category: "Temple",
      iconEmoji: "🌸", accentColor: C.saffron,
      description: "Sacred Shakti temple on a hilltop with panoramic views of the Shivalik ranges. Ideal for meditation.",
      bestTime: "Year Round",
      significance: "Goddess of supreme mother energy. Perfect for meditation.",
      tags: ["Shakti", "Hilltop", "Meditation"], hasVR: true, isTemple: true,
    ),
    DestinationModel(
      name: "ISKCON Temple Jammu",
      country: "India", region: "Jammu", category: "Temple",
      iconEmoji: "🎺", accentColor: C.royal,
      description: "Beautiful ISKCON temple with melodious kirtans, prasad distribution, and daily spiritual programs.",
      bestTime: "Janmashtami",
      significance: "Global Vaishnava Bhakti tradition, free prasad daily.",
      tags: ["ISKCON", "Bhakti", "Kirtan"], hasVR: true, isTemple: true,
    ),
    DestinationModel(
      name: "Talab Tillo Shiv Temple",
      country: "India", region: "Jammu", category: "Temple",
      iconEmoji: "🔱", accentColor: C.teal,
      description: "Famous Shiva temple near the historic Talab Tillo area. Lakhs gather here on Maha Shivratri.",
      bestTime: "Maha Shivratri",
      significance: "One of the most important Shivratri pilgrimage sites.",
      tags: ["Shaivite", "Shivratri", "Pilgrimage"], hasVR: true, isTemple: true,
    ),
    DestinationModel(
      name: "Sankat Mochan Hanuman",
      country: "India", region: "Jammu", category: "Temple",
      iconEmoji: "🐒", accentColor: Color(0xFFFF8C00),
      description: "Powerful Hanuman temple heavily visited on Tuesdays and Saturdays.",
      bestTime: "Tuesdays & Saturdays",
      significance: "Grants courage, strength, and protection from evil.",
      tags: ["Hanuman", "Protection", "Strength"], hasVR: true, isTemple: true,
    ),
    DestinationModel(
      name: "Lakshmi Narayan Temple",
      country: "India", region: "Jammu", category: "Temple",
      iconEmoji: "🌺", accentColor: C.royal,
      description: "Beautiful temple dedicated to Lord Vishnu and Goddess Lakshmi.",
      bestTime: "Diwali & Ekadashi",
      significance: "Blessings of prosperity, wealth, health, and happiness.",
      tags: ["Vaishnavite", "Prosperity", "Peace"], hasVR: true, isTemple: true,
    ),
    DestinationModel(
      name: "Purmandal Temples",
      country: "India", region: "Purmandal, Jammu", category: "Temple",
      iconEmoji: "🌊", accentColor: C.teal,
      description: "A cluster of temples on the banks of the Devika River. Known as the 'Chota Kashi' of Jammu.",
      bestTime: "Shivratri",
      significance: "Devika river considered as sacred as Ganga.",
      tags: ["Shaivite", "Pilgrimage", "River"], hasVR: false, isTemple: true,
    ),
    DestinationModel(
      name: "Shiv Khori Cave Temple",
      country: "India", region: "Reasi, Jammu", category: "Temple",
      iconEmoji: "🕳️", accentColor: C.teal,
      description: "A natural cave shrine 200 meters deep into a mountain. The cave has a 4-foot natural Shiva lingam.",
      bestTime: "Mar – Nov",
      significance: "Natural 4-foot Shivling in a mystical mountain cave.",
      tags: ["Cave", "Shaivite", "Natural Wonder"], hasVR: false, isTemple: true,
    ),
    DestinationModel(
      name: "Mansar Lake Temples",
      country: "India", region: "Mansar, Jammu", category: "Temple",
      iconEmoji: "🏞️", accentColor: C.gold,
      description: "Sacred lake with surrounding temples. Mansar Lake is considered blessed by Vishnu and Sheshnag.",
      bestTime: "April – June",
      significance: "Surrounded by temples, scenic pilgrimage destination.",
      tags: ["Scenic", "Multiple Deities", "Lake"], hasVR: false, isTemple: true,
    ),
    DestinationModel(
      name: "Nathatop Devi Temple",
      country: "India", region: "Patnitop, Jammu", category: "Temple",
      iconEmoji: "❄️", accentColor: C.saffron,
      description: "Hilltop Devi temple at Patnitop with snow-capped mountain backdrop.",
      bestTime: "Apr – Oct",
      significance: "Goddess Durga amidst Himalayan grandeur.",
      tags: ["Shakti", "Hilltop", "Mountain"], hasVR: false, isTemple: true,
    ),
    DestinationModel(
      name: "Dargah Peer Mitha",
      country: "India", region: "Jammu", category: "Shrine",
      iconEmoji: "☪️", accentColor: C.teal,
      description: "Revered Sufi dargah visited by people of all faiths. Symbol of communal harmony in Jammu.",
      bestTime: "Year Round",
      significance: "Communal harmony and spiritual blessings.",
      tags: ["Sufi", "All Faiths", "Harmony"], hasVR: false, isTemple: true,
    ),
    DestinationModel(
      name: "Sudh Mahadev Temple",
      country: "India", region: "Udhampur, Jammu", category: "Temple",
      iconEmoji: "🌲", accentColor: C.teal,
      description: "Ancient Shiva temple in dense deodar forests at 1225m altitude.",
      bestTime: "Jul – Aug (Mela)",
      significance: "Mahabharata-era trident and sacred forest location.",
      tags: ["Shaivite", "Forest", "Ancient"], hasVR: false, isTemple: true,
    ),
    DestinationModel(
      name: "Bathindi Temple",
      country: "India", region: "Jammu", category: "Temple",
      iconEmoji: "🔥", accentColor: C.saffron,
      description: "Powerful Bhavani Mata temple on the outskirts of Jammu city.",
      bestTime: "Navratri",
      significance: "Goddess Bhavani's blessings for courage and victory.",
      tags: ["Shakti", "Aarti", "Famous"], hasVR: false, isTemple: true,
    ),
    DestinationModel(
      name: "Bhaderwah Shiva Temple",
      country: "India", region: "Bhaderwah, Jammu", category: "Temple",
      iconEmoji: "🏔", accentColor: C.teal,
      description: "Ancient Shiva temple in the stunning valley of Bhaderwah known as 'Mini Kashmir'.",
      bestTime: "Jun – Sep",
      significance: "Lord Shiva amidst stunning Mini Kashmir valley.",
      tags: ["Shaivite", "Mountain", "Scenic"], hasVR: false, isTemple: true,
    ),
  ];

  static const List<DestinationModel> indiaTourism = [
    DestinationModel(
      name: "Taj Mahal",
      country: "India", region: "Agra, UP", category: "Heritage",
      iconEmoji: "🕌", accentColor: C.white,
      description: "The iconic symbol of eternal love. A UNESCO World Heritage Site and one of the Seven Wonders of the World.",
      bestTime: "Oct – Mar",
      significance: "Mughal architectural masterpiece, symbol of undying love.",
      tags: ["UNESCO", "Seven Wonders", "Must Visit"], hasVR: true,
    ),
    DestinationModel(
      name: "Kerala Backwaters",
      country: "India", region: "Kerala", category: "Nature",
      iconEmoji: "🚢", accentColor: C.teal,
      description: "Serene network of lagoons, lakes and canals parallel to the Arabian Sea coast.",
      bestTime: "Nov – Feb",
      significance: "Unique ecosystem, houseboat cruises, tropical paradise.",
      tags: ["Nature", "Houseboat", "Tropical"], hasVR: true,
    ),
    DestinationModel(
      name: "Ladakh",
      country: "India", region: "Ladakh, J&K", category: "Adventure",
      iconEmoji: "🏔", accentColor: C.teal,
      description: "The 'Land of High Passes' — barren mountains, Buddhist monasteries and crystal-clear skies.",
      bestTime: "Jun – Sep",
      significance: "World's highest motorable road, Pangong Lake, monasteries.",
      tags: ["Adventure", "Buddhist", "Mountains"], hasVR: true,
    ),
    DestinationModel(
      name: "Varanasi Ghats",
      country: "India", region: "Varanasi, UP", category: "Spiritual",
      iconEmoji: "🪔", accentColor: C.gold,
      description: "The oldest living city in the world. Sacred ghats, Ganga aarti, and spiritual awakening.",
      bestTime: "Oct – Mar",
      significance: "Moksha city, Ganga Aarti, ancient temples.",
      tags: ["Spiritual", "Ancient", "Ganga"], hasVR: true,
    ),
  ];

  static const List<DestinationModel> worldTourism = [
    DestinationModel(
      name: "Angkor Wat",
      country: "Cambodia", region: "Siem Reap", category: "Heritage",
      iconEmoji: "🏛", accentColor: C.gold,
      description: "The world's largest religious monument. Ancient Khmer Empire temple complex spread over 400 acres.",
      bestTime: "Nov – Mar",
      significance: "UNESCO World Heritage, ancient Hindu-Buddhist architecture.",
      tags: ["UNESCO", "Ancient", "Temple"], hasVR: true,
    ),
    DestinationModel(
      name: "Kyoto Temples",
      country: "Japan", region: "Kyoto", category: "Temple",
      iconEmoji: "⛩", accentColor: C.coral,
      description: "Japan's ancient capital with 17 UNESCO World Heritage temples, shrines and gardens.",
      bestTime: "Mar – May, Oct – Nov",
      significance: "Fushimi Inari, Golden Pavilion, zen gardens, cherry blossoms.",
      tags: ["UNESCO", "Zen", "Cherry Blossoms"], hasVR: true,
    ),
    DestinationModel(
      name: "Machu Picchu",
      country: "Peru", region: "Cusco", category: "Heritage",
      iconEmoji: "🏔", accentColor: C.teal,
      description: "The Lost City of the Incas perched at 7,970 feet in the Andes Mountains.",
      bestTime: "May – Oct",
      significance: "Seven Wonders, Inca civilization, mystical mountain ruins.",
      tags: ["Seven Wonders", "Inca", "UNESCO"], hasVR: true,
    ),
    DestinationModel(
      name: "Northern Lights",
      country: "Norway", region: "Tromsø", category: "Nature",
      iconEmoji: "🌌", accentColor: C.teal,
      description: "The magical Aurora Borealis — nature's most spectacular light show in the Arctic sky.",
      bestTime: "Sep – Mar",
      significance: "Aurora Borealis, Arctic wilderness, midnight sun.",
      tags: ["Aurora", "Arctic", "Nature"], hasVR: true,
    ),
    DestinationModel(
      name: "Pyramids of Giza",
      country: "Egypt", region: "Cairo", category: "Heritage",
      iconEmoji: "🔺", accentColor: Color(0xFFD4A76A),
      description: "The last remaining Wonder of the Ancient World — 4,500 years old and still standing.",
      bestTime: "Oct – Apr",
      significance: "Ancient Wonder, Pharaoh civilization, Sphinx.",
      tags: ["Ancient Wonder", "UNESCO", "Desert"], hasVR: true,
    ),
    DestinationModel(
      name: "Bali Temples",
      country: "Indonesia", region: "Bali", category: "Temple",
      iconEmoji: "🌺", accentColor: C.saffron,
      description: "Island of the Gods with thousands of temples, rice terraces and Hindu cultural traditions.",
      bestTime: "Apr – Oct",
      significance: "Tanah Lot, Uluwatu, rice terraces, Hindu culture.",
      tags: ["Hindu", "Beach", "Culture"], hasVR: true,
    ),
  ];
}

// ─────────────────────────────────────────────────────────────
//  PLANS
// ─────────────────────────────────────────────────────────────

class Plans {
  static final trial = PlanModel(
    id: 'trial', name: 'Trial', emoji: '🕉', price: 50, vrPrice: 40, trialDays: 5,
    color: const Color(0xFF2A3460), colorDark: const Color(0xFF2A3460),
    tagline: '5-day access — ₹50/mo',
    badge: '5-DAY TRIAL',
    features: const [
      '🥽 AnubhavX Unity VR Temple Simulation (APK)',
      '🎬 Launch temple.apk directly from app',
      '🎧 3D Spatial Audio Experience',
      '🌐 VR Headset Mode (360° split screen)',
      '✅ 5-Day Full VR Access',
      '🔔 Daily Sacred Reminders',
    ],
  );

  static const basic = PlanModel(
    id: 'basic', name: 'Basic', emoji: '🛕', price: 149, vrPrice: 40,
    color: Color(0xFF0F5F9E), colorDark: Color(0xFF0F5F9E),
    isPopular: true,
    tagline: 'All 30 Temples of Jammu — Unlocked',
    badge: 'MOST POPULAR',
    features: [
      '🛕 All 30 Jammu Temples — Full Access',
      '🥽 VR Darshan (Optional Add-on ₹40/mo)',
      '🔴 Live Temple Darshan via YouTube',
      '🎧 Full Immersive Audio Guide',
      '🤖 AI-Powered Temple Guide',
      '📍 Maps + Turn-by-Turn Directions',
      '🔔 Smart Aarti & Festival Alerts',
      '📿 Complete Temple History & Lore',
      '🌸 Festival Calendar',
      '❤️ Favourites & Bookmarks',
      '🌙 Daily Shloka, Mantra & Chalisa',
    ],
  );

  static const advanced = PlanModel(
    id: 'advanced', name: 'India', emoji: '🇮🇳', price: 349,
    color: Color(0xFF4A1A8E), colorDark: Color(0xFF4A1A8E),
    tagline: 'Full India Tourism Experience',
    badge: 'COMING SOON',
    comingSoon: true,
    features: [
      '🏔 All J&K + India Tourism',
      '🏰 Heritage Sites & Forts',
      '🌊 Beach & Nature Destinations',
      '🍛 Authentic Cuisine Guides',
      '🏨 Hotels & Homestay Directory',
      '📸 AR Photo Frames',
      '🚌 Route Planner & Transport',
      'Everything in Basic ✓',
    ],
  );

  static const pro = PlanModel(
    id: 'pro', name: 'World', emoji: '🌍', price: 799,
    color: Color(0xFF9A5600), colorDark: Color(0xFF9A5600),
    tagline: 'Worldwide Sacred Tourism',
    badge: 'COMING SOON',
    comingSoon: true,
    features: [
      '🌍 All India + Worldwide Sacred Sites',
      '🏛 UNESCO World Heritage Sites',
      '✈ AI Travel Planning Assistant',
      '💎 Premium Concierge 24/7',
      '👥 Group VR Darshan (Multi-user)',
      '🌐 Global Pilgrimage Network',
      'Everything in India Plan ✓',
    ],
  );

  static List<PlanModel> get all => [trial, basic, advanced, pro];
}

// ─────────────────────────────────────────────────────────────
//  ROOT APP
// ─────────────────────────────────────────────────────────────

class AnubhavXApp extends StatelessWidget {
  const AnubhavXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnubhavX',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: C.bg,
        colorScheme: const ColorScheme.dark(
          primary: C.gold,
          secondary: C.teal,
          surface: C.surface,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  SPLASH SCREEN
// ─────────────────────────────────────────────────────────────

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1800));

  late final AnimationController _glowCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 2))
    ..repeat(reverse: true);

  late final AnimationController _particleCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 12))
    ..repeat();

  late final AnimationController _orbitCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 8))
    ..repeat();

  late final Animation<double> _logoScale =
  CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut);

  late final Animation<double> _logoOpacity =
  Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoCtrl, curve: const Interval(0, 0.4)));

  late final Animation<double> _textOpacity =
  Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoCtrl, curve: const Interval(0.5, 1)));

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _logoCtrl.forward();

    await Future.delayed(const Duration(milliseconds: 3600));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    final plan = prefs.getString('userPlan') ?? '';

    Widget dest;

    if (!loggedIn) {
      dest = const LoginScreen();
    } else if (plan.isEmpty) {
      dest = const SubscriptionScreen();
    } else {
      dest = const MainScreen();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => dest,
        transitionsBuilder: (_, a, __, child) =>
            FadeTransition(opacity: a, child: child),
        transitionDuration: const Duration(milliseconds: 900),
      ),
    );
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _glowCtrl.dispose();
    _particleCtrl.dispose();
    _orbitCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: C.bg,
      body: Stack(
        children: [
          // BACKGROUND GRADIENT
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF03030A),
                  Color(0xFF060420),
                  Color(0xFF03030A)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // PARTICLES
          AnimatedBuilder(
            animation: _particleCtrl,
            builder: (_, __) => CustomPaint(
              painter: _SplashParticlePainter(_particleCtrl.value),
              size: size,
            ),
          ),

          // GLOW RING
          AnimatedBuilder(
            animation: _glowCtrl,
            builder: (_, __) => Center(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      C.gold.withOpacity(0.05 * _glowCtrl.value),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // MAIN CONTENT
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO ANIMATION
                ScaleTransition(
                  scale: _logoScale,
                  child: FadeTransition(
                    opacity: _logoOpacity,
                    child: AnimatedBuilder(
                      animation: _glowCtrl,
                      builder: (_, __) => Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1A0A38), Color(0xFF0A0820)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: C.gold
                                .withOpacity(0.3 + 0.2 * _glowCtrl.value),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: C.gold.withOpacity(0.4 * _glowCtrl.value),
                              blurRadius: 40,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/logo.png',
                            width: 300,
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 44),

                // TEXT SECTION
                FadeTransition(
                  opacity: _textOpacity,
                  child: Column(
                    children: [
                      Text(
                        'AnubhavX',
                        style: cinzel(
                          size: 48,
                          color: C.gold,
                          weight: FontWeight.w900,
                          spacing: 5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'WORLD TOURISM & VR EXPERIENCES',
                        style: cinzel(
                          size: 9.5,
                          color: C.white40,
                          weight: FontWeight.w400,
                          spacing: 6,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // DECOR LINE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 0.5,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, C.gold],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: C.gold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 60,
                            height: 0.5,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [C.gold, Colors.transparent],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      Text(
                        '✨  Experience the World Beyond Reality  ✨',
                        style: lato(size: 12, color: C.white40),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 70),

                // LOADING
                FadeTransition(
                  opacity: _textOpacity,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 180,
                        child: LinearProgressIndicator(
                          backgroundColor: C.white10,
                          valueColor:
                          const AlwaysStoppedAnimation<Color>(C.gold),
                          minHeight: 1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Connecting sacred experiences...',
                        style: lato(size: 11, color: C.white20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // FOOTER
          Positioned(
            bottom: 36,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _textOpacity,
              child: Text(
                '© 2025 AnubhavX Technologies Pvt. Ltd. · v4.1 · 🇮🇳',
                textAlign: TextAlign.center,
                style: lato(size: 10, color: C.white20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashParticlePainter extends CustomPainter {
  final double t;
  _SplashParticlePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final rng = math.Random(42);
    for (int i = 0; i < 80; i++) {
      final px = (rng.nextDouble() * size.width + t * (i.isEven ? 14.0 : -9.0)) % size.width;
      final py = (rng.nextDouble() * size.height + t * (i % 3 == 0 ? -18.0 : 14.0)) % size.height;
      final r = 0.5 + rng.nextDouble() * 1.5;
      final colors = [C.gold, C.teal, C.violet, C.saffron, C.white40];
      paint.color = colors[i % colors.length].withOpacity(0.02 + rng.nextDouble() * 0.05);
      canvas.drawCircle(Offset(px, py), r, paint);
    }
  }

  @override
  bool shouldRepaint(_SplashParticlePainter old) => old.t != t;
}

// ─────────────────────────────────────────────────────────────
//  GLOW ORB WIDGET
// ─────────────────────────────────────────────────────────────

class GlowOrb extends StatefulWidget {
  final Color color;
  final double size;
  final Duration delay;
  const GlowOrb({super.key, required this.color, this.size = 200, this.delay = Duration.zero});

  @override
  State<GlowOrb> createState() => _GlowOrbState();
}

class _GlowOrbState extends State<GlowOrb> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
  AnimationController(vsync: this, duration: const Duration(seconds: 5));
  late final Animation<double> _a =
  CurvedAnimation(parent: _c, curve: Curves.easeInOut);

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _c.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (_, __) => Transform.scale(
        scale: 1.0 + _a.value * 0.15,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withOpacity(0.12 + _a.value * 0.12),
            boxShadow: [
              BoxShadow(color: widget.color.withOpacity(0.2), blurRadius: 60)
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  GRADIENT BUTTON
// ═══════════════════════════════════════════════════════════════
class GradientButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final List<Color> colors;
  final Color shadowColor;
  final double height;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.colors = const [C.gold, C.saffron, C.ember],
    this.shadowColor = C.saffron,
    this.height = 54,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  late final Animation<double> _s =
  Tween<double>(begin: 1, end: 0.97).animate(_c);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onPressed == null;
    return GestureDetector(
      onTapDown: (_) { if (!disabled) _c.forward(); },
      onTapUp: (_) { _c.reverse(); widget.onPressed?.call(); },
      onTapCancel: () => _c.reverse(),
      child: AnimatedBuilder(
        animation: _s,
        builder: (_, child) => Transform.scale(scale: _s.value, child: child),
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: disabled
                  ? [const Color(0xFF333355), const Color(0xFF22223A)]
                  : widget.colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: disabled ? [] : [
              BoxShadow(
                color: widget.shadowColor.withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  GLASS INPUT FIELD
// ═══════════════════════════════════════════════════════════════
class GlassField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscure;
  final TextInputType keyboardType;
  final Widget? suffix;
  final String? Function(String?)? validator;

  const GlassField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(),
            style: lato(size: 10, color: C.white40, weight: FontWeight.w700, height: 1)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          validator: validator,
          style: lato(size: 14, color: C.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: lato(size: 14, color: C.white20),
            suffixIcon: suffix,
            filled: true,
            fillColor: C.white06,
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: C.white10)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: C.white10)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: C.gold, width: 1.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: C.coral)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: C.coral, width: 1.5)),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SOCIAL BUTTON
// ═══════════════════════════════════════════════════════════════
class _SocialBtn extends StatelessWidget {
  final String emoji;
  final String label;
  const _SocialBtn({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: C.white06,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: C.white10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 2),
            Text(label, style: lato(size: 9, color: C.white40)),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  LOGIN SCREEN
// ═══════════════════════════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late final TabController _tab = TabController(length: 2, vsync: this);

  final _loginKey  = GlobalKey<FormState>();
  final _signupKey = GlobalKey<FormState>();

  final _emailCtrl  = TextEditingController();
  final _passCtrl   = TextEditingController();
  final _nameCtrl   = TextEditingController();
  final _sEmailCtrl = TextEditingController();
  final _sPassCtrl  = TextEditingController();
  final _phoneCtrl  = TextEditingController();

  bool _loading  = false;
  bool _passVis  = false;
  bool _sPassVis = false;

  late final AnimationController _entry =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
  late final Animation<double> _fade =
  CurvedAnimation(parent: _entry, curve: Curves.easeOut);
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 0.08),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _entry, curve: Curves.easeOut));

  @override
  void initState() {
    super.initState();
    _entry.forward();
  }

  @override
  void dispose() {
    _tab.dispose();
    _entry.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    _sEmailCtrl.dispose();
    _sPassCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _snack(String msg, {Color bg = C.saffron}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: lato(size: 13, color: C.white)),
      backgroundColor: bg,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
    ));
  }

  Future<void> _login() async {
    if (!_loginKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool('isRegistered') ?? false)) {
      setState(() => _loading = false);
      _snack('Please create an account first');
      return;
    }

    await Future.delayed(const Duration(milliseconds: 1200));
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userName', _emailCtrl.text.split('@')[0]);
    await prefs.setString('userEmail', _emailCtrl.text);

    if (!mounted) return;
    setState(() => _loading = false);

    final plan = prefs.getString('userPlan') ?? '';
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (_) => plan.isEmpty ? const SubscriptionScreen() : const MainScreen(),
    ));
  }

  Future<void> _signup() async {
    if (!_signupKey.currentState!.validate()) return;
    setState(() => _loading = true);

    await Future.delayed(const Duration(milliseconds: 1200));
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isRegistered', true);
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userName', _nameCtrl.text);
    await prefs.setString('userEmail', _sEmailCtrl.text);
    await prefs.setString('userPhone', _phoneCtrl.text);

    if (!mounted) return;
    setState(() => _loading = false);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const SubscriptionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF050310), Color(0xFF0D0820), Color(0xFF050A20)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(top: -80, left: -60,
            child: GlowOrb(color: C.gold, size: 240, delay: Duration.zero)),
        Positioned(bottom: 60, right: -60,
            child: GlowOrb(color: C.violet, size: 210,
                delay: const Duration(milliseconds: 2500))),
        Positioned(top: 280, left: -30,
            child: GlowOrb(color: C.teal, size: 160,
                delay: const Duration(milliseconds: 1200))),
        SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(children: [
                  const SizedBox(height: 50),
                  _buildBrand(),
                  const SizedBox(height: 36),
                  _buildTabBar(),
                  const SizedBox(height: 22),
                  SizedBox(
                    height: 540,
                    child: TabBarView(
                      controller: _tab,
                      children: [_loginForm(), _signupForm()],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildBrand() => Column(children: [
    Container(
      width: 70, height: 70,
      decoration: BoxDecoration(
        gradient: C.fireGrad,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(color: C.gold.withOpacity(0.5), blurRadius: 36, offset: const Offset(0, 8)),
        ],
      ),
      child: const Center(child: Text('🛕', style: TextStyle(fontSize: 34))),
    ),
    const SizedBox(height: 16),
    ShaderMask(
      shaderCallback: (b) =>
          const LinearGradient(colors: [C.gold, C.goldLight, C.gold]).createShader(b),
      child: Text('AnubhavX',
          style: cinzel(size: 34, weight: FontWeight.w900, spacing: 2, color: Colors.white)),
    ),
    const SizedBox(height: 5),
    Text('DIVINE VR EXPERIENCES',
        style: lato(size: 10, color: C.white40, weight: FontWeight.w600, height: 1)),
  ]);

  Widget _buildTabBar() => Container(
    decoration: BoxDecoration(
      color: C.white06,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: C.white10),
    ),
    padding: const EdgeInsets.all(4),
    child: TabBar(
      controller: _tab,
      indicator: BoxDecoration(
        gradient: C.fireGrad,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(color: C.saffron.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 4))
        ],
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      labelColor: const Color(0xFF1A0800),
      unselectedLabelColor: C.white40,
      labelStyle: lato(size: 13, weight: FontWeight.w700, color: Color(0xFF1A0800)),
      unselectedLabelStyle: lato(size: 13, color: C.white40),
      tabs: const [Tab(text: 'Sign In'), Tab(text: 'Sign Up')],
    ),
  );

  Widget _loginForm() => Form(
    key: _loginKey,
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      GlassField(
        controller: _emailCtrl, label: 'Email Address', hint: 'you@example.com',
        keyboardType: TextInputType.emailAddress,
        validator: (v) => v!.isEmpty ? 'Enter your email' : null,
      ),
      const SizedBox(height: 16),
      GlassField(
        controller: _passCtrl, label: 'Password', hint: '••••••••',
        obscure: !_passVis,
        validator: (v) => v!.length < 6 ? 'Minimum 6 characters' : null,
        suffix: IconButton(
          icon: Icon(_passVis ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: C.white40, size: 20),
          onPressed: () => setState(() => _passVis = !_passVis),
        ),
      ),
      const SizedBox(height: 10),
      Align(
        alignment: Alignment.centerRight,
        child: Text('Forgot password?',
            style: lato(size: 12, color: C.gold, weight: FontWeight.w600, height: 1)),
      ),
      const SizedBox(height: 24),
      GradientButton(
        onPressed: _loading ? null : _login,
        colors: const [C.gold, C.saffron, C.ember],
        shadowColor: C.saffron,
        child: _loading
            ? const SizedBox(width: 22, height: 22,
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Enter the Temple',
              style: cinzel(size: 13, color: Color(0xFF1A0800),
                  weight: FontWeight.w900, spacing: 1)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_rounded, color: Color(0xFF1A0800), size: 18),
        ]),
      ),
      const SizedBox(height: 22),
      Row(children: [
        Expanded(child: Divider(color: C.white10, thickness: 0.5)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text('or continue with', style: lato(size: 11, color: C.white40)),
        ),
        Expanded(child: Divider(color: C.white10, thickness: 0.5)),
      ]),
      const SizedBox(height: 18),
      const Row(children: [
        _SocialBtn(emoji: 'G', label: 'Google'),
        SizedBox(width: 10),
        _SocialBtn(emoji: '🍎', label: 'Apple'),
        SizedBox(width: 10),
        _SocialBtn(emoji: '📱', label: 'Phone'),
      ]),
      const SizedBox(height: 24),
      Center(
        child: GestureDetector(
          onTap: () => _tab.animateTo(1),
          child: RichText(text: TextSpan(children: [
            TextSpan(text: 'New here?  ', style: lato(size: 13, color: C.white40)),
            TextSpan(text: 'Create Account',
                style: lato(size: 13, color: C.gold, weight: FontWeight.w700, height: 1)),
          ])),
        ),
      ),
    ]),
  );

  Widget _signupForm() => Form(
    key: _signupKey,
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      GlassField(
        controller: _nameCtrl, label: 'Full Name', hint: 'Arjun Sharma',
        validator: (v) => v!.isEmpty ? 'Enter your name' : null,
      ),
      const SizedBox(height: 14),
      GlassField(
        controller: _sEmailCtrl, label: 'Email Address', hint: 'you@example.com',
        keyboardType: TextInputType.emailAddress,
        validator: (v) => v!.isEmpty ? 'Enter your email' : null,
      ),
      const SizedBox(height: 14),
      GlassField(
        controller: _phoneCtrl, label: 'Phone Number', hint: '+91 98765 43210',
        keyboardType: TextInputType.phone,
        validator: (v) => v!.length < 10 ? 'Invalid phone number' : null,
      ),
      const SizedBox(height: 14),
      GlassField(
        controller: _sPassCtrl, label: 'Password', hint: '••••••••',
        obscure: !_sPassVis,
        validator: (v) => v!.length < 6 ? 'Minimum 6 characters' : null,
        suffix: IconButton(
          icon: Icon(_sPassVis ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: C.white40, size: 20),
          onPressed: () => setState(() => _sPassVis = !_sPassVis),
        ),
      ),
      const SizedBox(height: 24),
      GradientButton(
        onPressed: _loading ? null : _signup,
        colors: const [C.violet, Color(0xFF9333EA), C.violetLight],
        shadowColor: C.violet,
        child: _loading
            ? const SizedBox(width: 22, height: 22,
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : Text('Create Sacred Account  ✦',
            style: cinzel(size: 12, weight: FontWeight.w900, spacing: 0.8)),
      ),
      const SizedBox(height: 14),
      Center(
        child: RichText(textAlign: TextAlign.center, text: TextSpan(children: [
          TextSpan(text: 'By creating, you agree to our ',
              style: lato(size: 11, color: C.white20)),
          TextSpan(text: 'Terms',
              style: lato(size: 11, color: C.violetLight, weight: FontWeight.w600, height: 1)),
          TextSpan(text: '  &  ', style: lato(size: 11, color: C.white20)),
          TextSpan(text: 'Privacy Policy',
              style: lato(size: 11, color: C.violetLight, weight: FontWeight.w600, height: 1)),
        ])),
      ),
    ]),
  );
}

// ═══════════════════════════════════════════════════════════════
//  PLAN CARD DATA MODEL
// ═══════════════════════════════════════════════════════════════
class PlanData {
  final String name, duration, emoji, badge;
  final int price;
  final bool isPopular;
  final int? vrPrice;
  final String? vrText;
  final Color primary, shadow;
  final List<Color> gradient;
  final List<String> features;

  const PlanData({
    required this.name, required this.price, required this.duration,
    required this.emoji, required this.badge, this.isPopular = false,
    this.vrPrice, this.vrText,
    required this.primary, required this.shadow,
    required this.gradient, required this.features,
  });
}

const List<PlanData> kPlans = [
  PlanData(
    name: 'Trial', price: 50, duration: 'per month',
    emoji: '⚡', badge: 'Starter',
    vrPrice: 40, vrText: 'for 5 days',
    primary: Color(0xFF6B7FCC), shadow: Color(0xFF4A5580),
    gradient: [Color(0xFF4A5580), Color(0xFF6B7FCC)],
    features: ['Basic access', 'Limited temples', 'Standard VR'],
  ),
  PlanData(
    name: 'Basic', price: 999, duration: 'one time',
    emoji: '💎', badge: 'Essential',
    primary: C.royalLight, shadow: C.royal,
    gradient: [C.royalDark, C.royal, C.royalLight],
    features: ['Full temple access', 'HD experience', 'AI guide'],
  ),
  PlanData(
    name: 'Advanced', price: 19999, duration: 'premium',
    emoji: '🌟', badge: 'Most Popular', isPopular: true,
    primary: C.violetLight, shadow: C.violet,
    gradient: [C.violetDark, C.violet, C.violetLight],
    features: ['360° VR temples', 'Advanced AI guide', 'Priority support'],
  ),
  PlanData(
    name: 'Pro', price: 49999, duration: 'ultimate',
    emoji: '👑', badge: 'Ultimate',
    primary: C.gold, shadow: C.goldDark,
    gradient: [C.goldDark, C.gold, C.goldLight],
    features: ['Ultra VR experience', 'Live darshan', 'All features'],
  ),
];

// ═══════════════════════════════════════════════════════════════
//  PLAN CARD
// ═══════════════════════════════════════════════════════════════
class PlanCard extends StatefulWidget {
  final PlanData plan;
  final bool selected;
  final bool vrAddon;
  final VoidCallback onTap;
  final void Function(bool)? onVrToggle;

  const PlanCard({
    super.key,
    required this.plan, required this.selected,
    required this.vrAddon, required this.onTap,
    this.onVrToggle,
  });

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 220));
  late final Animation<double> _s =
  Tween<double>(begin: 1, end: 1.04)
      .animate(CurvedAnimation(parent: _c, curve: Curves.easeOut));

  @override
  void initState() {
    super.initState();
    if (widget.selected) _c.value = 1;
  }

  @override
  void didUpdateWidget(covariant PlanCard old) {
    super.didUpdateWidget(old);
    widget.selected ? _c.forward() : _c.reverse();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  String _fmt(int p) => p >= 1000
      ? p.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')
      : p.toString();

  @override
  Widget build(BuildContext context) {
    final p = widget.plan;
    final sel = widget.selected;
    return AnimatedBuilder(
      animation: _s,
      builder: (_, child) => Transform.scale(scale: _s.value, child: child),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: sel ? p.primary.withOpacity(0.12) : C.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: sel ? p.primary : C.cardBorder, width: sel ? 1.8 : 1),
            boxShadow: sel ? [
              BoxShadow(color: p.shadow.withOpacity(0.3), blurRadius: 24, offset: const Offset(0, 6))
            ] : [],
          ),
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: p.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text('${p.emoji} ${p.badge}'.toUpperCase(),
                    style: lato(size: 8, color: p.primary, weight: FontWeight.w800, height: 1)),
              ),
              const SizedBox(height: 10),
              Text(p.name, style: cinzel(size: 16, weight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text('₹${_fmt(p.price)}',
                  style: lato(size: 20, color: p.primary, weight: FontWeight.w800, height: 1.2)),
              Text(p.duration.toUpperCase(),
                  style: lato(size: 8, color: C.white40, height: 1.6)),
              const SizedBox(height: 10),
              ...p.features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('✦ ', style: TextStyle(fontSize: 8, color: p.primary)),
                    Expanded(child: Text(f, style: lato(size: 9.5, color: C.white60))),
                  ],
                ),
              )),
              const Spacer(),
              if (p.vrPrice != null)
                GestureDetector(
                  onTap: widget.onVrToggle != null
                      ? () => widget.onVrToggle!(!widget.vrAddon) : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: widget.vrAddon ? C.teal.withOpacity(0.12) : C.white06,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                          color: widget.vrAddon ? C.teal.withOpacity(0.4) : C.white10),
                    ),
                    child: Row(children: [
                      SizedBox(
                        width: 16, height: 16,
                        child: Checkbox(
                          value: widget.vrAddon,
                          onChanged: widget.onVrToggle != null
                              ? (v) => widget.onVrToggle!(v!) : null,
                          activeColor: C.teal,
                          side: const BorderSide(color: C.white40),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text('+₹${p.vrPrice} VR ${p.vrText}',
                            style: lato(size: 9, color: C.white60)),
                      ),
                    ]),
                  ),
                ),
            ]),
            if (p.isPopular)
              Positioned(
                top: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    gradient: C.fireGrad,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [BoxShadow(color: C.gold.withOpacity(0.4), blurRadius: 10)],
                  ),
                  child: Text('HOT 🔥',
                      style: lato(size: 8, color: Color(0xFF1A0800),
                          weight: FontWeight.w800, height: 1)),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SUBSCRIPTION SCREEN
// ═══════════════════════════════════════════════════════════════
class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with SingleTickerProviderStateMixin {
  int _sel = 0;
  bool _vr = false;
  bool _paying = false;

  // ── Razorpay ──────────────────────────────────────────────
  late Razorpay _razorpay;

  // ⚠️  REPLACE with your real Razorpay Key ID from dashboard.razorpay.com
  static const String _razorpayKey = 'rzp_test_YourKeyHere';

  late final AnimationController _entry =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 750));

  late final Animation<double> _fade =
  CurvedAnimation(parent: _entry, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    _entry.forward();

    // Initialise Razorpay and attach event handlers
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,   _onPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();   // release listeners
    _entry.dispose();
    super.dispose();
  }

  PlanData get plan => kPlans[_sel];

  int get total =>
      plan.price + (_vr && plan.vrPrice != null ? plan.vrPrice! : 0);

  String _fmt(int p) => p >= 1000
      ? p.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')
      : p.toString();

  // ── Open Razorpay payment sheet (Blinkit-style) ──────────
  void _subscribe() {
    setState(() => _paying = true);

    final options = {
      'key'         : _razorpayKey,
      'amount'      : total * 100,          // Razorpay expects paise (₹1 = 100p)
      'name'        : 'AnubhavX',
      'description' : '${plan.name} Plan',
      'image'       : 'https://i.imgur.com/n5tjHFD.png', // replace with your logo URL
      'currency'    : 'INR',
      'prefill'     : {
        'name'    : '',
        'email'   : '',
        'contact' : '',
      },
      'theme'       : {
        'color'            : '#7C3AED',   // purple brand colour
        'hide_topbar'      : false,
      },
      // Show all methods: UPI (GPay, PhonePe, Paytm), Cards, Wallets, NetBanking
      'method'      : {
        'upi'        : true,
        'card'       : true,
        'wallet'     : true,
        'netbanking' : true,
        'emi'        : false,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() => _paying = false);
      _showSnack('Could not open payment. Try again.', isError: true);
    }
  }

  // ── Callbacks ─────────────────────────────────────────────
  Future<void> _onPaymentSuccess(PaymentSuccessResponse response) async {
    // Payment successful — save plan and navigate
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userPlan', plan.name.toLowerCase());
    await prefs.setBool('vrAddon', _vr);

    if (!mounted) return;
    setState(() => _paying = false);

    _showSnack('🙏 Payment successful! Welcome to ${plan.name} plan.');

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  void _onPaymentError(PaymentFailureResponse response) {
    setState(() => _paying = false);
    _showSnack(
      response.message ?? 'Payment failed. Please try again.',
      isError: true,
    );
  }

  void _onExternalWallet(ExternalWalletResponse response) {
    setState(() => _paying = false);
    _showSnack('Opening ${response.walletName}…');
  }

  void _showSnack(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(color: Colors.white)),
      backgroundColor: isError ? Colors.red.shade700 : const Color(0xFF7C3AED),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF04020F),
                  Color(0xFF08051A),
                  Color(0xFF040820)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Glow elements
          Positioned(
            top: -70,
            left: -70,
            child: GlowOrb(color: C.violet, size: 270, delay: Duration.zero),
          ),
          Positioned(
            bottom: 130,
            right: -60,
            child: GlowOrb(
              color: plan.primary,
              size: 230,
              delay: const Duration(milliseconds: 2000),
            ),
          ),

          SafeArea(
            child: FadeTransition(
              opacity: _fade,
              child: Column(
                children: [
                  const SizedBox(height: 22),
                  _header(),
                  const SizedBox(height: 16),
                  Expanded(child: _grid()),
                  _bottomBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() => Column(
    children: [
      const Text('🛕', style: TextStyle(fontSize: 40)),
      const SizedBox(height: 8),
      ShaderMask(
        shaderCallback: (b) => const LinearGradient(
          colors: [C.gold, C.goldLight, C.gold],
        ).createShader(b),
        child: Text(
          'Choose Your Path',
          style: cinzel(
            size: 24,
            weight: FontWeight.w900,
            spacing: 1,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 5),
      Text(
        'UNLOCK IMMERSIVE VR TEMPLE EXPERIENCES',
        style: lato(
          size: 9,
          color: C.white40,
          weight: FontWeight.w600,
          height: 1,
        ),
      ),
    ],
  );

  // ---------------- RESPONSIVE GRID ----------------
  Widget _grid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double w = constraints.maxWidth;

        int crossAxisCount;
        double aspectRatio;

        if (w < 600) {
          crossAxisCount = 2;
          aspectRatio = 0.78;
        } else if (w < 1000) {
          crossAxisCount = 3;
          aspectRatio = 0.82;
        } else {
          crossAxisCount = 4;
          aspectRatio = 0.9;
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          itemCount: kPlans.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: aspectRatio,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          itemBuilder: (_, i) {
            final selected = i == _sel;

            return AnimatedScale(
              duration: const Duration(milliseconds: 250),
              scale: selected ? 1.03 : 1.0,
              child: PlanCard(
                plan: kPlans[i],
                selected: selected,
                vrAddon: _vr && selected,
                onTap: () => setState(() {
                  _sel = i;
                  if (kPlans[i].vrPrice == null) _vr = false;
                }),
                onVrToggle:
                selected ? (v) => setState(() => _vr = v) : null,
              ),
            );
          },
        );
      },
    );
  }

  // ---------------- BOTTOM BAR ----------------
  Widget _bottomBar() => Container(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF07061A), Color(0xFF0B0A22)],
      ),
      border: const Border(
        top: BorderSide(color: Colors.white10),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 20,
          offset: const Offset(0, -5),
        )
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL DUE',
                  style: lato(
                    size: 9,
                    color: C.white40,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  plan.name,
                  style: cinzel(
                    size: 15,
                    weight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ShaderMask(
              shaderCallback: (b) => const LinearGradient(
                colors: [C.gold, C.goldLight],
              ).createShader(b),
              child: Text(
                '₹${_fmt(total)}',
                style: cinzel(
                  size: 28,
                  weight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        GradientButton(
          onPressed: _paying ? null : _subscribe,
          colors: plan.gradient,
          shadowColor: plan.shadow,
          height: 54,
          child: _paying
              ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : Text(
            '${plan.emoji}  Begin Sacred Journey',
            style: cinzel(
              size: 12,
              color: Colors.white,
              weight: FontWeight.w900,
              spacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '🔒  Secure payment  ·  Cancel anytime',
          style: lato(size: 10, color: C.white20),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
//  MAIN SCREEN (Nav Shell)
// ═══════════════════════════════════════════════════════════════
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _navIdx = 0;
  String _userPlan = 'trial';

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  Future<void> _loadPlan() async {
    final p = await SharedPreferences.getInstance();
    setState(() => _userPlan = p.getString('userPlan') ?? 'trial');
  }

  bool get _isTrialUser =>
      _userPlan != 'basic' && _userPlan != 'advanced' && _userPlan != 'pro';

  @override
  Widget build(BuildContext context) {
    final pages = [
      _isTrialUser ? const _TrialHomeScreen() : const _BasicHomeScreen(),
      const _ExploreTab(),
      const _VRTab(),
      const _ProfileTab(),
    ];

    return Scaffold(
      backgroundColor: C.bg,
      body: IndexedStack(index: _navIdx, children: pages),
      bottomNavigationBar: _buildNav(),
    );
  }

  Widget _buildNav() => Container(
    decoration: const BoxDecoration(
      color: C.surface,
      border: Border(top: BorderSide(color: C.cardBorder, width: 0.5)),
    ),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(0, Icons.explore_outlined, Icons.explore, 'Discover'),
            _navItem(1, Icons.travel_explore_outlined, Icons.travel_explore, 'Explore'),
            _navItem(2, Icons.vrpano_outlined, Icons.vrpano, 'VR'),
            _navItem(3, Icons.person_outline, Icons.person, 'Profile'),
          ],
        ),
      ),
    ),
  );

  Widget _navItem(int i, IconData icon, IconData aIcon, String label) {
    final sel = i == _navIdx;
    return GestureDetector(
      onTap: () => setState(() => _navIdx = i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 230),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          gradient: sel ? const LinearGradient(colors: [C.gold, C.saffron]) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(sel ? aIcon : icon, color: sel ? C.bg : C.white40, size: 22),
            const SizedBox(height: 3),
            Text(label, style: lato(size: 10, color: sel ? C.bg : C.white40,
                weight: sel ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  TRIAL HOME SCREEN  —  Only shows VR APK launcher
//  Trial users see: big VR launch button + upgrade prompt
// ═══════════════════════════════════════════════════════════════

class _TrialHomeScreen extends StatefulWidget {
  const _TrialHomeScreen();

  @override
  State<_TrialHomeScreen> createState() => _TrialHomeScreenState();
}

class _TrialHomeScreenState extends State<_TrialHomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _glowCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 2))
    ..repeat(reverse: true);
  late final AnimationController _orbitCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 6))
    ..repeat();
  late final AnimationController _fadeCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900))
    ..forward();

  late final Animation<double> _glow =
  Tween<double>(begin: 0.4, end: 1.0).animate(_glowCtrl);
  late final Animation<double> _fade =
  CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);

  @override
  void dispose() {
    _glowCtrl.dispose();
    _orbitCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  /// Extracts temple.apk from assets → temp dir → launches via intent
  Future<void> _launchTempleAPK() async {
    try {
      // Extract APK from assets
      final byteData = await rootBundle.load('assets/temple.apk');
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/temple.apk');
      await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

      // Launch using platform channel (AndroidIntentPlus or method channel)
      const channel = MethodChannel('anubhavx/apk_launcher');
      await channel.invokeMethod('launchAPK', {'path': file.path});
    } catch (e) {
      // Fallback: show Unity widget inside app
      if (mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const TempleVRScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _fade,
        child: Stack(
          children: [
            // Deep space bg
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.2,
                  colors: [Color(0xFF0A1A1A), Color(0xFF030308)],
                ),
              ),
            ),

            // Top safe area content
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ── Header ──
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('🙏  Namaste, Explorer',
                                    style: lato(size: 12, color: C.gold)),
                                Text('AnubhavX VR',
                                    style: cinzel(size: 26, color: C.white,
                                        weight: FontWeight.w800)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: C.trialC.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                              border:
                              Border.all(color: C.trialC.withOpacity(0.35)),
                            ),
                            child: Text('🕉 Trial',
                                style: cinzel(size: 10, color: C.trialC,
                                    weight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    // ── Animated VR Headset ──
                    AnimatedBuilder(
                      animation: _glowCtrl,
                      builder: (_, __) => SizedBox(
                        width: 300,
                        height: 300,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer pulse ring
                            Container(
                              width: 290,
                              height: 290,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    C.teal.withOpacity(
                                        0.04 * _glow.value),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            // Inner ring
                            Container(
                              width: 230,
                              height: 230,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: C.gold.withOpacity(
                                      0.06 * _glow.value),
                                  width: 1,
                                ),
                              ),
                            ),
                            // Core circle
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const RadialGradient(
                                  colors: [
                                    Color(0xFF052020),
                                    Color(0xFF010A0A)
                                  ],
                                ),
                                border: Border.all(
                                  color: C.teal.withOpacity(
                                      0.25 + 0.15 * _glow.value),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: C.teal
                                        .withOpacity(0.45 * _glow.value),
                                    blurRadius: 70,
                                    spreadRadius: 8,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text('🥽',
                                    style: TextStyle(fontSize: 86)),
                              ),
                            ),
                            // Orbiting dots
                            AnimatedBuilder(
                              animation: _orbitCtrl,
                              builder: (_, __) => SizedBox(
                                width: 300,
                                height: 300,
                                child: Stack(
                                  children: List.generate(4, (i) {
                                    final angle = _orbitCtrl.value *
                                        2 *
                                        math.pi +
                                        (i * math.pi / 2);
                                    return Positioned(
                                      left: 150 +
                                          118 * math.cos(angle) -
                                          5,
                                      top: 150 +
                                          118 * math.sin(angle) -
                                          5,
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: [
                                            C.gold,
                                            C.teal,
                                            C.saffron,
                                            C.violet
                                          ][i].withOpacity(0.75),
                                          boxShadow: [
                                            BoxShadow(
                                              color: [
                                                C.gold,
                                                C.teal,
                                                C.saffron,
                                                C.violet
                                              ][i].withOpacity(0.5),
                                              blurRadius: 8,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Title ──
                    Text('AnubhavX Unity VR Simulation',
                        textAlign: TextAlign.center,
                        style: cinzel(size: 20, color: C.white,
                            weight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text('temple.apk  ·  Unity Engine  ·  5-Day Trial',
                        textAlign: TextAlign.center,
                        style: lato(size: 12, color: C.teal)),

                    const SizedBox(height: 24),

                    // ── Feature pills ──
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _trialFeaturePill('🎧', '3D Spatial\nAudio'),
                          const SizedBox(width: 14),
                          _trialFeaturePill('🌐', '360°\nImmersive'),
                          const SizedBox(width: 14),
                          _trialFeaturePill('🥽', 'VR Headset\nReady'),
                          const SizedBox(width: 14),
                          _trialFeaturePill('✨', 'Unity\nEngine'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Instructions card ──
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF0A1A10),
                              Color(0xFF060E08)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border:
                          Border.all(color: C.teal.withOpacity(0.2)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: C.teal.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('💡',
                                  style: TextStyle(fontSize: 22)),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text('How to use',
                                      style: cinzel(size: 12,
                                          color: C.teal,
                                          weight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  Text(
                                    '1. Tap "Launch VR Simulation" below\n2. temple.apk will open\n3. Wear your VR headset\n4. Experience sacred temples in 360°!',
                                    style: lato(size: 12,
                                        color: C.white60, height: 1.7),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── LAUNCH BUTTON ──
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AnimatedBuilder(
                        animation: _glowCtrl,
                        builder: (_, child) => DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [C.teal, C.tealDark]),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: C.teal.withOpacity(
                                    0.4 + 0.2 * _glow.value),
                                blurRadius: 40,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: child!,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 68,
                          child: ElevatedButton(
                            onPressed: _launchTempleAPK,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Text('🥽',
                                    style: TextStyle(fontSize: 28)),
                                const SizedBox(width: 14),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text('Launch VR Simulation',
                                        style: cinzel(
                                            size: 15,
                                            color: C.bg,
                                            weight: FontWeight.bold)),
                                    Text('temple.apk  ·  Unity Engine',
                                        style: lato(
                                            size: 11,
                                            color: C.bg.withOpacity(0.65))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Upgrade prompt ──
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                const SubscriptionScreen())),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: C.gold.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(16),
                            border:
                            Border.all(color: C.gold.withOpacity(0.25)),
                          ),
                          child: Row(
                            children: [
                              const Text('🛕',
                                  style: TextStyle(fontSize: 28)),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text('Unlock 30 Jammu Temples',
                                        style: cinzel(
                                            size: 13,
                                            color: C.gold,
                                            weight: FontWeight.bold)),
                                    Text(
                                        'Basic Plan · ₹149/mo · AI guide + Live Aarti',
                                        style: lato(
                                            size: 11,
                                            color: C.white40)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: C.fireGrad,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('Upgrade',
                                    style: cinzel(
                                        size: 11,
                                        color: C.bg,
                                        weight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trialFeaturePill(String emoji, String label) => Column(
    children: [
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: C.teal.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: C.teal.withOpacity(0.3)),
        ),
        child: Center(child: Text(emoji, style: const TextStyle(fontSize: 24))),
      ),
      const SizedBox(height: 6),
      Text(label, textAlign: TextAlign.center,
          style: lato(size: 9, color: C.white40)),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════
//  BASIC HOME SCREEN  —  Full Professional Beautiful HomeScreen
//  For paid Basic/Advanced/Pro users
// ═══════════════════════════════════════════════════════════════

class _BasicHomeScreen extends StatefulWidget {
  const _BasicHomeScreen();

  @override
  State<_BasicHomeScreen> createState() => _BasicHomeScreenState();
}

class _BasicHomeScreenState extends State<_BasicHomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _headerCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1200))
    ..forward();
  late final AnimationController _pulseCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 3))
    ..repeat(reverse: true);

  late final Animation<double> _headerFade =
  CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOut);
  late final Animation<Offset> _headerSlide = Tween<Offset>(
    begin: const Offset(0, -0.1),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOut));

  String _userName = 'Explorer';
  int _bannerPage = 0;
  final _pageCtrl = PageController();

  @override
  void initState() {
    super.initState();
    _loadUser();
    _startBannerAuto();
  }

  Future<void> _loadUser() async {
    final p = await SharedPreferences.getInstance();
    setState(() => _userName = p.getString('userName') ?? 'Explorer');
  }

  void _startBannerAuto() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      final next = (_bannerPage + 1) % 4;
      _pageCtrl.animateToPage(next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut);
      setState(() => _bannerPage = next);
      _startBannerAuto();
    });
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    _pulseCtrl.dispose();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeroHeader(context)),
          SliverToBoxAdapter(child: _buildFeaturedBanners(context)),
          SliverToBoxAdapter(child: _buildDailyHighlight()),
          SliverToBoxAdapter(child: _buildCategories(context)),
          SliverToBoxAdapter(child: _buildTempleGrid(context)),
          SliverToBoxAdapter(child: _buildAartiSchedule()),
          SliverToBoxAdapter(child: _buildDailyShloka()),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  // ── Hero Header ──
  Widget _buildHeroHeader(BuildContext context) {
    return SlideTransition(
      position: _headerSlide,
      child: FadeTransition(
        opacity: _headerFade,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF12063A), Color(0xFF0A0520), C.bg],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('🙏  Jai Mata Di',
                                style: lato(size: 11, color: C.gold)),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Namaste, ',
                                  style: cinzel(size: 22, color: C.white60,
                                      weight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: _userName,
                                  style: cinzel(size: 22, color: C.white,
                                      weight: FontWeight.w800),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      // Live badge
                      AnimatedBuilder(
                        animation: _pulseCtrl,
                        builder: (_, __) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xFF8B0000), Color(0xFFCC0000)]),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(
                                    0.4 * _pulseCtrl.value),
                                blurRadius: 16,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7, height: 7,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              Text('LIVE',
                                  style: cinzel(size: 10, color: Colors.white,
                                      weight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: C.white10,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: C.cardBorder),
                    ),
                    child: TextField(
                      style: lato(color: C.white),
                      decoration: InputDecoration(
                        hintText:
                        'Search temples, destinations, experiences...',
                        hintStyle: lato(size: 13, color: C.white20),
                        prefixIcon:
                        const Icon(Icons.search, color: C.gold, size: 20),
                        suffixIcon: Container(
                          margin: const EdgeInsets.all(7),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: C.fireGrad,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.tune, color: C.bg, size: 14),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Quick stats row
                  Row(
                    children: [
                      _quickStat('🛕', '30', 'Temples'),
                      const SizedBox(width: 10),
                      _quickStat('🥽', '18', 'VR Ready'),
                      const SizedBox(width: 10),
                      _quickStat('🔴', 'Live', 'Aarti'),
                      const SizedBox(width: 10),
                      _quickStat('🤖', 'AI', 'Guide'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _quickStat(String emoji, String value, String label) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: C.white06,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: C.cardBorder),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text(value, style: cinzel(size: 13, color: C.gold, weight: FontWeight.w800)),
          Text(label, style: lato(size: 9, color: C.white40)),
        ],
      ),
    ),
  );

  // ── Featured Banners ──
  Widget _buildFeaturedBanners(BuildContext context) {
    final banners = [
      {
        'emoji': '🏔',
        'title': 'Vaishno Devi Darshan',
        'sub': 'Sacred Himalayan Pilgrimage • 5200 ft',
        'badge': '🔴 LIVE AARTI',
        'c1': const Color(0xFF1A0430),
        'c2': const Color(0xFF4A1A6E),
      },
      {
        'emoji': '🛕',
        'title': 'Raghunath Temple',
        'sub': 'Gold-Plated Shrine • Jammu City',
        'badge': '🥽 VR READY',
        'c1': const Color(0xFF1A0A00),
        'c2': const Color(0xFF5A2A00),
      },
      {
        'emoji': '🔱',
        'title': 'Ranbireshwar Temple',
        'sub': '7.5 ft Shiva Lingam • Crystal Shrine',
        'badge': '✨ FEATURED',
        'c1': const Color(0xFF002A2A),
        'c2': const Color(0xFF005A50),
      },
      {
        'emoji': '⚔️',
        'title': 'Bahu Fort Kali Temple',
        'sub': '3000-Year Heritage • Navratri Special',
        'badge': '🌟 MUST VISIT',
        'c1': const Color(0xFF1A0000),
        'c2': const Color(0xFF5A0A00),
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageCtrl,
              onPageChanged: (i) => setState(() => _bannerPage = i),
              itemCount: banners.length,
              itemBuilder: (_, i) {
                final b = banners[i];
                final dest = DestinationData.jammuTemples[i];
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              DestinationDetailScreen(destination: dest))),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [b['c1'] as Color, b['c2'] as Color],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: C.gold.withOpacity(0.14)),
                    ),
                    child: Stack(
                      children: [
                        // Big emoji
                        Positioned(
                          right: -10,
                          top: -10,
                          child: Text(b['emoji'] as String,
                              style: const TextStyle(fontSize: 120)),
                        ),
                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            gradient: LinearGradient(
                              colors: [
                                (b['c1'] as Color).withOpacity(0.9),
                                Colors.transparent
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(b['badge'] as String,
                                    style: lato(
                                        size: 10,
                                        color: Colors.white,
                                        weight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 10),
                              Text(b['title'] as String,
                                  style: cinzel(size: 20, color: C.white,
                                      weight: FontWeight.w800)),
                              const SizedBox(height: 4),
                              Text(b['sub'] as String,
                                  style: lato(size: 11, color: C.white60)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Dots indicator
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              banners.length,
                  (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _bannerPage ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: i == _bannerPage ? C.gold : C.white20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Daily Highlight Card ──
  Widget _buildDailyHighlight() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A0930), Color(0xFF0A0520)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: C.gold.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
                color: C.gold.withOpacity(0.06),
                blurRadius: 30,
                offset: const Offset(0, 8)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: C.fireGrad,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: C.gold.withOpacity(0.4), blurRadius: 20)
                ],
              ),
              child: const Center(
                  child: Text('🪔', style: TextStyle(fontSize: 36))),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: C.gold.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('TODAY\'S HIGHLIGHT',
                        style: lato(
                            size: 9,
                            color: C.gold,
                            weight: FontWeight.w800,
                            height: 1)),
                  ),
                  const SizedBox(height: 6),
                  Text('Evening Sandhya Aarti',
                      style: cinzel(size: 15, color: C.white,
                          weight: FontWeight.w700)),
                  Text('Vaishno Devi • 7:00 PM tonight',
                      style: lato(size: 11, color: C.white40)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _smallChip('🔴 Live', C.coral),
                      const SizedBox(width: 8),
                      _smallChip('🥽 VR', C.teal),
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

  Widget _smallChip(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.35)),
    ),
    child: Text(label, style: lato(size: 10, color: color, weight: FontWeight.bold)),
  );

  // ── Categories ──
  Widget _buildCategories(BuildContext context) {
    final cats = [
      {'emoji': '🛕', 'label': 'Temples', 'color': C.gold, 'count': '30'},
      {'emoji': '🏛', 'label': 'Heritage', 'color': Color(0xFFD4A76A), 'count': '12'},
      {'emoji': '🥽', 'label': 'VR Ready', 'color': C.teal, 'count': '18'},
      {'emoji': '🌸', 'label': 'Shakti', 'color': C.saffron, 'count': '14'},
      {'emoji': '🔱', 'label': 'Shaivite', 'color': C.teal, 'count': '8'},
      {'emoji': '🌍', 'label': 'World', 'color': C.violet, 'count': '6'},
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Browse Categories',
                    style: cinzel(size: 14, color: C.gold, weight: FontWeight.w700)),
                Text('All →', style: lato(size: 12, color: C.teal)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 96,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: cats.length,
              itemBuilder: (_, i) {
                final c = cats[i];
                final color = c['color'] as Color;
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 80,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: color.withOpacity(0.22)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(c['emoji'] as String,
                            style: const TextStyle(fontSize: 26)),
                        const SizedBox(height: 5),
                        Text(c['label'] as String,
                            style: lato(size: 10, color: color,
                                weight: FontWeight.w600)),
                        Text(c['count'] as String,
                            style: lato(size: 9, color: C.white20)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Temple Grid ──
  Widget _buildTempleGrid(BuildContext context) {
    final temples = DestinationData.jammuTemples.take(6).toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Jammu Temples',
                  style: cinzel(size: 14, color: C.gold, weight: FontWeight.w700)),
              GestureDetector(
                onTap: () {},
                child: Text('See All 30 →', style: lato(size: 12, color: C.teal)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: temples.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, i) => _templeCard(context, temples[i]),
          ),
        ],
      ),
    );
  }

  Widget _templeCard(BuildContext context, DestinationModel d) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(
              builder: (_) => DestinationDetailScreen(destination: d))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              d.accentColor.withOpacity(0.18),
              C.card,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: d.accentColor.withOpacity(0.18)),
        ),
        child: Column(
          children: [
            // Emoji area
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Text(d.iconEmoji,
                        style: const TextStyle(fontSize: 52)),
                  ),
                  if (d.hasVR)
                    Positioned(
                      top: 8, right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: C.teal.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(6),
                          border:
                          Border.all(color: C.teal.withOpacity(0.4)),
                        ),
                        child: Text('🥽',
                            style: lato(size: 9, color: C.teal,
                                weight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(d.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: cinzel(size: 11, color: C.white,
                          weight: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Text(d.region,
                      style: lato(size: 10, color: d.accentColor)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined,
                          size: 9, color: C.white40),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(d.bestTime,
                            overflow: TextOverflow.ellipsis,
                            style: lato(size: 9, color: C.white40)),
                      ),
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

  // ── Aarti Schedule ──
  Widget _buildAartiSchedule() {
    final aartis = [
      ['5:00 AM', 'Mangal Aarti', 'Raghunath Temple', '🔴'],
      ['6:30 AM', 'Pratah Aarti', 'Ranbireshwar Temple', '🟡'],
      ['12:00 PM', 'Madhyan Aarti', 'Bahu Fort Kali', '🟡'],
      ['7:00 PM', 'Sandhya Aarti', 'Vaishno Devi', '🔴'],
      ['10:00 PM', 'Shayan Aarti', 'Raghunath Temple', '🟡'],
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today's Aarti Schedule",
                  style: cinzel(size: 14, color: C.gold,
                      weight: FontWeight.w700)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: C.saffron.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: C.saffron.withOpacity(0.3)),
                ),
                child: Text('5 Today',
                    style: lato(size: 10, color: C.saffron,
                        weight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...aartis.map((a) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: C.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: C.cardBorder),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: C.gold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(a[0],
                      style: cinzel(size: 11, color: C.gold,
                          weight: FontWeight.bold)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a[1],
                          style: cinzel(size: 12, color: C.white,
                              weight: FontWeight.w600)),
                      Text(a[2],
                          style: lato(size: 11, color: C.white40)),
                    ],
                  ),
                ),
                Text(a[3], style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: C.gold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.notifications_none,
                      color: C.gold, size: 16),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // ── Daily Shloka ──
  Widget _buildDailyShloka() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A163A), Color(0xFF0E0E2A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: C.gold.withOpacity(0.18)),
          boxShadow: [
            BoxShadow(
                color: C.gold.withOpacity(0.05),
                blurRadius: 30,
                offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: C.fireGrad,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('📿', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Daily Shloka',
                          style: cinzel(size: 13, color: C.gold,
                              weight: FontWeight.bold)),
                      Text('Bhagavad Gita 4.7',
                          style: lato(size: 10, color: C.white40)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: C.white06,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.share_outlined,
                      color: C.white40, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, C.gold.withOpacity(0.3),
                    Colors.transparent],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'यदा यदा हि धर्मस्य ग्लानिर्भवति भारत।\nअभ्युत्थानमधर्मस्य तदात्मानं सृजाम्यहम्॥',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansDevanagari(
                  color: C.goldLight, fontSize: 15, height: 1.9),
            ),
            const SizedBox(height: 16),
            Text(
              '"Whenever dharma declines and adharma rises,\nI manifest Myself." — Lord Krishna',
              textAlign: TextAlign.center,
              style: lato(size: 12, color: C.white40, height: 1.7),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  EXPLORE TAB
// ─────────────────────────────────────────────────────────────

class _ExploreTab extends StatefulWidget {
  const _ExploreTab();
  @override
  State<_ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<_ExploreTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tab = TabController(length: 3, vsync: this);
  String _userPlan = 'trial';
  String _search   = '';

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  Future<void> _loadPlan() async {
    final p = await SharedPreferences.getInstance();
    setState(() => _userPlan = p.getString('userPlan') ?? 'trial');
  }

  bool get _isPaidUser =>
      _userPlan == 'basic' || _userPlan == 'advanced' || _userPlan == 'pro';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: TabBarView(
            controller: _tab,
            children: [
              _templesList(context),
              _destList(context, DestinationData.indiaTourism, 'india'),
              _destList(context, DestinationData.worldTourism, 'world'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0C0820), C.bg],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Explore',
                            style: cinzel(size: 28, color: C.gold,
                                weight: FontWeight.w800)),
                        Text('Temples · India · World',
                            style: lato(size: 13, color: C.white40)),
                      ],
                    ),
                  ),
                  if (!_isPaidUser)
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => const SubscriptionScreen())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: C.fireGrad,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Upgrade',
                            style: cinzel(size: 11, color: C.bg,
                                weight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: C.white10,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: C.cardBorder),
                ),
                child: TextField(
                  onChanged: (v) => setState(() => _search = v),
                  style: lato(color: C.white),
                  decoration: InputDecoration(
                    hintText: 'Search destinations...',
                    hintStyle: lato(size: 13, color: C.white20),
                    prefixIcon:
                    const Icon(Icons.search, color: C.gold, size: 18),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 13),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: C.white06,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: C.cardBorder),
                ),
                child: TabBar(
                  controller: _tab,
                  indicator: BoxDecoration(
                    gradient: C.fireGrad,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  dividerColor: Colors.transparent,
                  labelColor: C.bg,
                  unselectedLabelColor: C.white40,
                  labelStyle: cinzel(size: 11, weight: FontWeight.bold),
                  unselectedLabelStyle: cinzel(size: 11),
                  tabs: const [
                    Tab(text: '🛕 Temples'),
                    Tab(text: '🇮🇳 India'),
                    Tab(text: '🌍 World'),
                  ],
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _templesList(BuildContext context) {
    if (!_isPaidUser) return _lockScreen(context, '🛕', 'Temples', 'basic');

    final temples = DestinationData.jammuTemples
        .where((t) => _search.isEmpty ||
        t.name.toLowerCase().contains(_search.toLowerCase()))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      itemCount: temples.length,
      itemBuilder: (_, i) => _destCard(context, temples[i]),
    );
  }

  Widget _destList(BuildContext context, List<DestinationModel> data,
      String key) {
    if (!_isPaidUser && key == 'india') {
      return _lockScreen(context, '🇮🇳', 'India Tourism', 'advanced');
    }

    final list = data
        .where((d) => _search.isEmpty ||
        d.name.toLowerCase().contains(_search.toLowerCase()) ||
        d.country.toLowerCase().contains(_search.toLowerCase()))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      itemCount: list.length,
      itemBuilder: (_, i) => _destCard(context, list[i]),
    );
  }

  Widget _lockScreen(BuildContext context, String emoji, String name,
      String requiredPlan) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 120),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A0838), Color(0xFF0A0A20)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: C.gold.withOpacity(0.22)),
          ),
          child: Column(
            children: [
              const Text('🔒', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 16),
              Text('$emoji  $name Locked',
                  style: cinzel(size: 20, color: C.gold,
                      weight: FontWeight.w800)),
              const SizedBox(height: 10),
              Text(
                'Upgrade to unlock $name and all immersive experiences.',
                textAlign: TextAlign.center,
                style: lato(size: 13, color: C.white40, height: 1.6),
              ),
              const SizedBox(height: 22),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const SubscriptionScreen())),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: C.fireGrad,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: C.gold.withOpacity(0.35),
                          blurRadius: 22, offset: const Offset(0, 6)),
                    ],
                  ),
                  child: Text('View Plans & Upgrade',
                      textAlign: TextAlign.center,
                      style: cinzel(size: 13, color: C.bg,
                          weight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _destCard(BuildContext context, DestinationModel d) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(
              builder: (_) => DestinationDetailScreen(destination: d))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: C.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: C.cardBorder),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [
                    d.accentColor.withOpacity(0.32),
                    d.accentColor.withOpacity(0.04)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 10, top: 6,
                    child: Text(d.iconEmoji,
                        style: const TextStyle(fontSize: 62)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Wrap(
                      spacing: 6,
                      children: d.tags.take(2).map((tag) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: C.white10,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(tag,
                            style: lato(size: 9, color: C.white,
                                weight: FontWeight.bold)),
                      )).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(d.name,
                            style: cinzel(size: 15, color: C.white,
                                weight: FontWeight.w700)),
                      ),
                      const Icon(Icons.chevron_right,
                          size: 16, color: C.white40),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          color: C.gold, size: 12),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text('${d.region}, ${d.country}',
                            overflow: TextOverflow.ellipsis,
                            style: lato(size: 11, color: C.white40)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(d.category,
                      style: lato(size: 12, color: d.accentColor,
                          weight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(d.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: lato(size: 12, color: C.white40, height: 1.5)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _chip(Icons.calendar_today_outlined, d.bestTime, C.gold),
                      const SizedBox(width: 8),
                      if (d.hasVR)
                        _chip(Icons.vrpano_outlined, 'VR Ready', C.teal),
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

  Widget _chip(IconData icon, String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: 4),
        Text(label, style: lato(size: 10, color: color, weight: FontWeight.w600)),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
//  DESTINATION DETAIL SCREEN
// ─────────────────────────────────────────────────────────────

class DestinationDetailScreen extends StatelessWidget {
  final DestinationModel destination;
  const DestinationDetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    final d = destination;
    return Scaffold(
      backgroundColor: C.bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: C.bg,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 18),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [d.accentColor.withOpacity(0.28), C.bg],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 44),
                      Text(d.iconEmoji, style: const TextStyle(fontSize: 100)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: C.fireGrad,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('${d.category} · ${d.country}',
                            style: cinzel(size: 11, color: C.bg,
                                weight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(d.name,
                      style: cinzel(size: 28, color: C.white,
                          weight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: C.gold, size: 14),
                      const SizedBox(width: 5),
                      Text('${d.region}, ${d.country}',
                          style: lato(size: 12, color: C.white40)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: d.tags.map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: d.accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: d.accentColor.withOpacity(0.3)),
                      ),
                      child: Text(t,
                          style: lato(size: 11, color: d.accentColor,
                              weight: FontWeight.w600)),
                    )).toList(),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                          child: _infoCard('🕐', 'Best Time', d.bestTime)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _infoCard('🏷', 'Category', d.category)),
                    ],
                  ),
                  const SizedBox(height: 22),
                  _section('About', d.description),
                  const SizedBox(height: 18),
                  _section('Why Visit', d.significance),
                  const SizedBox(height: 26),
                  if (d.hasVR)
                    _actionBtn('🥽  Start VR Experience', C.teal, () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  VRDarshanScreen(destination: d)));
                    }),
                  if (d.hasVR) const SizedBox(height: 12),
                  _actionBtn('📍  Get Directions', C.royal, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Opening Maps for ${d.name}...')));
                  }),
                  const SizedBox(height: 12),
                  _actionBtn('🌐  Learn More Online', C.violet, () {}),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String emoji, String label, String value) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: C.card,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: C.cardBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$emoji  $label',
            style:
            lato(size: 11, color: C.gold, weight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(value, style: lato(size: 11, color: C.white60, height: 1.4)),
      ],
    ),
  );

  Widget _section(String title, String body) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: cinzel(size: 13, color: C.gold, weight: FontWeight.w700)),
      const SizedBox(height: 8),
      Text(body, style: lato(size: 13, color: C.white60, height: 1.7)),
    ],
  );

  Widget _actionBtn(String label, Color color, VoidCallback onTap) =>
      SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(label,
              style: cinzel(size: 13, color: Colors.white,
                  weight: FontWeight.bold)),
        ),
      );
}

// ─────────────────────────────────────────────────────────────
//  VR DARSHAN SCREEN
//  Trial → directly launches temple.apk (Unity)
//  Paid  → full in-app VR experience
// ─────────────────────────────────────────────────────────────

class VRDarshanScreen extends StatefulWidget {
  final DestinationModel? destination;
  const VRDarshanScreen({super.key, this.destination});

  @override
  State<VRDarshanScreen> createState() => _VRDarshanScreenState();
}

class _VRDarshanScreenState extends State<VRDarshanScreen>
    with TickerProviderStateMixin {
  bool _headsetMode = false;
  bool _playing     = false;
  bool _launching   = false;
  double _progress  = 0;
  String _userPlan  = 'trial';

  late final AnimationController _pulseCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 2))
    ..repeat(reverse: true);
  late final AnimationController _glowCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1600))
    ..repeat(reverse: true);
  late final AnimationController _rotateCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 22))
    ..repeat();
  late final AnimationController _progressCtrl = AnimationController(
      vsync: this, duration: const Duration(minutes: 5));
  late final AnimationController _orbitCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 6))
    ..repeat();

  late final Animation<double> _pulse = Tween<double>(begin: 0.95, end: 1.06)
      .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  late final Animation<double> _glow = Tween<double>(begin: 0.4, end: 1.0)
      .animate(_glowCtrl);

  @override
  void initState() {
    super.initState();
    _loadPlan();
    _progressCtrl.addListener(
            () => setState(() => _progress = _progressCtrl.value));
  }

  Future<void> _loadPlan() async {
    final p = await SharedPreferences.getInstance();
    setState(() => _userPlan = p.getString('userPlan') ?? 'trial');
  }

  bool get _isTrialUser =>
      _userPlan != 'basic' && _userPlan != 'advanced' && _userPlan != 'pro';

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _glowCtrl.dispose();
    _rotateCtrl.dispose();
    _progressCtrl.dispose();
    _orbitCtrl.dispose();
    super.dispose();
  }

  void _startPlaying() {
    setState(() => _playing = true);
    _progressCtrl.forward();
  }

  void _stopPlaying() {
    setState(() => _playing = false);
    _progressCtrl.stop();
    _progressCtrl.reset();
  }

  /// Launch temple.apk: extract from assets → temp file → open via intent
  Future<void> _launchAPK() async {
    setState(() => _launching = true);
    try {
      final data = await rootBundle.load('assets/temple.apk');
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/temple.apk');
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);

      const channel = MethodChannel('anubhavx/apk_launcher');
      await channel.invokeMethod('launchAPK', {'path': file.path});
      setState(() => _launching = false);
    } catch (_) {
      setState(() => _launching = false);
      // Fallback: open UnityWidget inside app
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const TempleVRScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Trial: only show APK launcher
    if (_isTrialUser) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(child: _trialAPKScreen()),
              _buildTrialLaunchButton(),
            ],
          ),
        ),
      );
    }

    // Paid: full VR experience
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: _playing
                  ? (_headsetMode ? _vrSplitView() : _playingView())
                  : _idleView(),
            ),
            _buildPaidControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: C.white10,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 18),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.destination?.name ?? 'AnubhavX VR Experience',
                style: cinzel(size: 14, color: C.gold,
                    weight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                _isTrialUser ? '🥽 Trial — APK Mode' : '📱 360° Experience',
                style: lato(size: 10, color: C.white40),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [C.teal, C.tealDark]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('🥽 VR',
              style: cinzel(size: 10, color: Colors.white,
                  weight: FontWeight.bold)),
        ),
      ],
    ),
  );

  // ─ Trial APK Content ─
  Widget _trialAPKScreen() => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Animated headset
          AnimatedBuilder(
            animation: _glowCtrl,
            builder: (_, __) => SizedBox(
              width: 260,
              height: 260,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          C.teal.withOpacity(
                              0.05 * _glow.value),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [
                          Color(0xFF042020),
                          Color(0xFF010808)
                        ],
                      ),
                      border: Border.all(
                        color: C.teal.withOpacity(
                            0.22 + 0.14 * _glow.value),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: C.teal
                              .withOpacity(0.4 * _glow.value),
                          blurRadius: 60,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('🥽',
                          style: TextStyle(fontSize: 80)),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _orbitCtrl,
                    builder: (_, __) => SizedBox(
                      width: 260,
                      height: 260,
                      child: Stack(
                        children: List.generate(3, (i) {
                          final angle = _orbitCtrl.value *
                              2 * math.pi +
                              (i * 2 * math.pi / 3);
                          return Positioned(
                            left: 130 + 108 * math.cos(angle) - 5,
                            top: 130 + 108 * math.sin(angle) - 5,
                            child: Container(
                              width: 10, height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: [C.gold, C.teal, C.saffron][i]
                                    .withOpacity(0.75),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('AnubhavX Unity VR',
              textAlign: TextAlign.center,
              style: cinzel(size: 22, color: C.white,
                  weight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text('Temple Simulation v3.1  ·  Powered by Unity',
              style: lato(size: 12, color: C.teal)),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFF0A1A2A), Color(0xFF060C14)]),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: C.teal.withOpacity(0.22)),
            ),
            child: Column(
              children: [
                Text(
                  'Your 5-day trial includes exclusive access to the AnubhavX Unity VR Temple Simulation.\n\nExperience sacred temples in full 360° immersive VR!',
                  textAlign: TextAlign.center,
                  style:
                  lato(size: 13, color: C.white60, height: 1.65),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _vrFeaturePill('🎧', '3D Spatial\nAudio'),
                    _vrFeaturePill('🌐', '360°\nView'),
                    _vrFeaturePill('✨', 'Unity\nEngine'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: C.gold.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: C.gold.withOpacity(0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💡', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('How to use:',
                          style: cinzel(size: 11, color: C.gold,
                              weight: FontWeight.bold)),
                      Text(
                        '1. Tap "Launch VR Simulation"\n2. temple.apk will open\n3. Put on your VR headset\n4. Enjoy 360° darshan!',
                        style: lato(size: 11, color: C.white40,
                            height: 1.7),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _vrFeaturePill(String emoji, String label) => Column(
    children: [
      Container(
        width: 52, height: 52,
        decoration: BoxDecoration(
          color: C.teal.withOpacity(0.12),
          shape: BoxShape.circle,
          border: Border.all(color: C.teal.withOpacity(0.3)),
        ),
        child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 22))),
      ),
      const SizedBox(height: 6),
      Text(label,
          textAlign: TextAlign.center,
          style: lato(size: 9, color: C.white40)),
    ],
  );

  // ─ Trial Launch Button ─
  Widget _buildTrialLaunchButton() => Container(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
    decoration: const BoxDecoration(
      color: Color(0xFF060B10),
      border: Border(top: BorderSide(color: C.cardBorder, width: 0.5)),
    ),
    child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _glowCtrl,
            builder: (_, child) => DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [C.teal, C.tealDark]),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color:
                    C.teal.withOpacity(0.35 + 0.2 * _glow.value),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: child!,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _launching ? null : _launchAPK,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                child: _launching
                    ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.5, color: C.bg))
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🥽',
                        style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Text(
                        'Launch VR Simulation (temple.apk)',
                        style: cinzel(size: 13, color: C.bg,
                            weight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text('temple.apk · AnubhavX Unity Engine · 5-day trial',
              textAlign: TextAlign.center,
              style: lato(size: 10, color: C.white20)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const SubscriptionScreen())),
            child: Text('Upgrade to Basic for full temples →',
                textAlign: TextAlign.center,
                style:
                lato(size: 11, color: C.gold, weight: FontWeight.w600)),
          ),
        ],
      ),
    ),
  );

  // ─ Paid: Idle View ─
  Widget _idleView() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: Listenable.merge([_pulseCtrl, _glowCtrl]),
          builder: (_, __) => Transform.scale(
            scale: _pulse.value,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                    colors: [Color(0xFF1A0A2E), Colors.black]),
                boxShadow: [
                  BoxShadow(
                      color: (widget.destination?.accentColor ?? C.gold)
                          .withOpacity(0.3 * _glow.value),
                      blurRadius: 60,
                      spreadRadius: 10),
                ],
                border: Border.all(
                    color: C.gold.withOpacity(0.25), width: 1.5),
              ),
              child: Center(
                child: Text(
                  widget.destination?.iconEmoji ?? '🥽',
                  style: const TextStyle(fontSize: 70),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        Text(widget.destination?.name ?? 'AnubhavX VR Darshan',
            textAlign: TextAlign.center,
            style: cinzel(size: 20, color: C.white,
                weight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text(
            widget.destination?.category ?? 'Sacred Virtual Experience',
            textAlign: TextAlign.center,
            style: lato(size: 13, color: C.white40)),
      ],
    ),
  );

  // ─ Paid: Playing View ─
  Widget _playingView() => Stack(
    children: [
      AnimatedBuilder(
        animation: _rotateCtrl,
        builder: (_, __) {
          final angle = _rotateCtrl.value * 2 * math.pi;
          final ac = widget.destination?.accentColor ?? C.gold;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF0A0822),
                  ac.withOpacity(0.28),
                  const Color(0xFF1A0A30),
                ],
                begin: AlignmentDirectional(
                    math.cos(angle), math.sin(angle)),
                end: AlignmentDirectional(
                    -math.cos(angle), -math.sin(angle)),
              ),
            ),
          );
        },
      ),
      AnimatedBuilder(
        animation: _rotateCtrl,
        builder: (_, __) => CustomPaint(
          painter: _StarfieldPainter(_rotateCtrl.value,
              widget.destination?.accentColor ?? C.gold),
          child: const SizedBox.expand(),
        ),
      ),
      Center(
        child: AnimatedBuilder(
          animation: _glowCtrl,
          builder: (_, __) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                      colors: [Color(0xFF2A0A4A), Colors.black]),
                  boxShadow: [
                    BoxShadow(
                        color: (widget.destination?.accentColor ?? C.gold)
                            .withOpacity(0.5 * _glow.value),
                        blurRadius: 50,
                        spreadRadius: 10)
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.destination?.iconEmoji ?? '🛕',
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('🎧 Immersive Experience Active',
                  style: lato(size: 12, color: C.teal,
                      weight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text('Move your phone to explore 360°',
                  style: lato(size: 11, color: C.white40)),
            ],
          ),
        ),
      ),
      Positioned(top: 16, left: 16,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 7, height: 7,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white)),
              const SizedBox(width: 5),
              Text('LIVE', style: lato(size: 10, color: Colors.white,
                  weight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 0, left: 0, right: 0,
        child: LinearProgressIndicator(
          value: _progress,
          backgroundColor: C.white10,
          valueColor: const AlwaysStoppedAnimation<Color>(C.gold),
          minHeight: 3,
        ),
      ),
    ],
  );

  // ─ VR Split View ─
  Widget _vrSplitView() => Row(
    children: [
      Expanded(child: _vrEye(isLeft: true)),
      Container(width: 2, color: Colors.black),
      Expanded(child: _vrEye(isLeft: false)),
    ],
  );

  Widget _vrEye({required bool isLeft}) => Stack(
    children: [
      AnimatedBuilder(
        animation: _rotateCtrl,
        builder: (_, __) {
          final offset = isLeft ? 0.0 : 0.08;
          final angle = (_rotateCtrl.value + offset) * 2 * math.pi;
          final ac = widget.destination?.accentColor ?? C.gold;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF0A0822),
                  ac.withOpacity(0.35),
                  const Color(0xFF1A0A30),
                ],
                begin: AlignmentDirectional(
                    math.cos(angle), math.sin(angle)),
                end: AlignmentDirectional(
                    -math.cos(angle), -math.sin(angle)),
              ),
            ),
          );
        },
      ),
      Center(
        child: AnimatedBuilder(
          animation: _glowCtrl,
          builder: (_, __) => Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: (widget.destination?.accentColor ?? C.gold)
                        .withOpacity(0.5 * _glow.value),
                    blurRadius: 30)
              ],
            ),
            child: Center(
              child: Text(
                widget.destination?.iconEmoji ?? '🛕',
                style: const TextStyle(fontSize: 46),
              ),
            ),
          ),
        ),
      ),
    ],
  );

  // ─ Paid Controls ─
  Widget _buildPaidControls() => Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Color(0xFF080816),
      border: Border(top: BorderSide(color: C.cardBorder, width: 0.5)),
    ),
    child: Column(children: [
      if (!_playing) ...[
        _headsetToggle(),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [C.gold, C.saffron]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: C.gold.withOpacity(0.4),
                    blurRadius: 24, offset: const Offset(0, 8)),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: _startPlaying,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              icon: const Icon(Icons.play_arrow_rounded,
                  color: C.bg, size: 28),
              label: Text(
                _headsetMode
                    ? 'Start VR Experience  🥽'
                    : 'Play 360° Darshan  ▶',
                style: cinzel(size: 14, color: C.bg,
                    weight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ] else ...[
        Row(children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _stopPlaying,
              icon: const Icon(Icons.stop_rounded, size: 18),
              label: Text('Stop',
                  style: cinzel(size: 12, weight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () =>
                  setState(() => _headsetMode = !_headsetMode),
              icon: Text(_headsetMode ? '📱' : '🥽',
                  style: const TextStyle(fontSize: 16)),
              label: Text(_headsetMode ? 'Mobile' : 'VR Mode',
                  style: cinzel(size: 12, color: C.bg,
                      weight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _headsetMode ? C.teal : C.gold,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ]),
      ],
    ]),
  );

  Widget _headsetToggle() => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _headsetMode ? C.teal.withOpacity(0.1) : C.white10,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
          color: _headsetMode ? C.teal.withOpacity(0.4) : C.cardBorder),
    ),
    child: Row(children: [
      const Text('🥽', style: TextStyle(fontSize: 22)),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('VR Headset Mode',
                style: cinzel(size: 12, color: C.white,
                    weight: FontWeight.bold)),
            Text(_headsetMode
                ? 'Side-by-side 360° view active'
                : 'Toggle for split-screen VR',
                style: lato(size: 10, color: C.white40)),
          ],
        ),
      ),
      GestureDetector(
        onTap: () => setState(() => _headsetMode = !_headsetMode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50, height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: _headsetMode ? C.teal : C.white20,
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            alignment: _headsetMode
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              width: 24, height: 24,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
            ),
          ),
        ),
      ),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────
//  STARFIELD PAINTER
// ─────────────────────────────────────────────────────────────

class _StarfieldPainter extends CustomPainter {
  final double t;
  final Color accent;
  _StarfieldPainter(this.t, this.accent);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final rng = math.Random(99);
    for (int i = 0; i < 70; i++) {
      final angle = rng.nextDouble() * 2 * math.pi + t * 0.3;
      final dist = rng.nextDouble() * size.width * 0.55;
      final cx = size.width / 2 + dist * math.cos(angle);
      final cy = size.height / 2 + dist * math.sin(angle);
      final r = 0.5 + rng.nextDouble() * 2.0;
      paint.color = (i % 4 == 0 ? accent : i % 3 == 0 ? C.gold : C.white)
          .withOpacity(0.03 + rng.nextDouble() * 0.07);
      canvas.drawCircle(Offset(cx, cy), r, paint);
    }
  }

  @override
  bool shouldRepaint(_StarfieldPainter old) => old.t != t;
}

// ─────────────────────────────────────────────────────────────
//  VR TAB
// ─────────────────────────────────────────────────────────────

class _VRTab extends StatefulWidget {
  const _VRTab();
  @override
  State<_VRTab> createState() => _VRTabState();
}

class _VRTabState extends State<_VRTab> with TickerProviderStateMixin {
  String _userPlan = 'trial';
  late final AnimationController _glowCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 2))
    ..repeat(reverse: true);
  late final AnimationController _orbitCtrl = AnimationController(
      vsync: this, duration: const Duration(seconds: 5))
    ..repeat();

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    _orbitCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadPlan() async {
    final p = await SharedPreferences.getInstance();
    setState(() => _userPlan = p.getString('userPlan') ?? 'trial');
  }

  bool get _isTrialUser =>
      _userPlan != 'basic' && _userPlan != 'advanced' && _userPlan != 'pro';

  @override
  Widget build(BuildContext context) {
    if (_isTrialUser) return _trialVRPage(context);
    return _paidVRPage(context);
  }

  Widget _trialVRPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('VR Darshan',
                                style: cinzel(size: 28, color: C.teal,
                                    weight: FontWeight.w800)),
                            Text('Trial · APK Simulation Mode',
                                style: lato(size: 13, color: C.white40)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: C.trialC.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: C.trialC.withOpacity(0.4)),
                        ),
                        child: Text('🕉 Trial',
                            style: cinzel(size: 10, color: C.trialC,
                                weight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                AnimatedBuilder(
                  animation: _glowCtrl,
                  builder: (_, __) => SizedBox(
                    width: 280, height: 280,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 280, height: 280,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                C.teal.withOpacity(
                                    0.05 * _glowCtrl.value),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 200, height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const RadialGradient(
                              colors: [
                                Color(0xFF042020),
                                Color(0xFF010808)
                              ],
                            ),
                            border: Border.all(
                              color: C.teal.withOpacity(
                                  0.2 + 0.1 * _glowCtrl.value),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: C.teal.withOpacity(
                                    0.4 * _glowCtrl.value),
                                blurRadius: 60,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: const Center(
                            child:
                            Text('🥽', style: TextStyle(fontSize: 90)),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _orbitCtrl,
                          builder: (_, __) => SizedBox(
                            width: 280, height: 280,
                            child: Stack(
                              children: List.generate(4, (i) {
                                final angle =
                                    _orbitCtrl.value * 2 * math.pi +
                                        (i * math.pi / 2);
                                return Positioned(
                                  left: 140 + 110 * math.cos(angle) - 5,
                                  top: 140 + 110 * math.sin(angle) - 5,
                                  child: Container(
                                    width: 10, height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: [C.gold, C.teal, C.saffron,
                                        C.violet][i].withOpacity(0.6),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(children: [
                    Text('AnubhavX Unity VR Simulation',
                        textAlign: TextAlign.center,
                        style: cinzel(size: 20, color: C.white,
                            weight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(
                      'Your trial gives exclusive access to the temple.apk Unity VR simulation.\nNo temple browsing — pure immersive VR!',
                      textAlign: TextAlign.center,
                      style: lato(size: 13, color: C.white40, height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    AnimatedBuilder(
                      animation: _glowCtrl,
                      builder: (_, child) => DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [C.teal, C.tealDark]),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                                color: C.teal.withOpacity(
                                    0.4 + 0.2 * _glowCtrl.value),
                                blurRadius: 36,
                                offset: const Offset(0, 10)),
                          ],
                        ),
                        child: child!,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                  const VRDarshanScreen())),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('🥽',
                                  style: TextStyle(fontSize: 28)),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text('Launch VR Simulation',
                                      style: cinzel(size: 15,
                                          color: C.bg,
                                          weight: FontWeight.bold)),
                                  Text('temple.apk · Unity Engine',
                                      style: lato(size: 10,
                                          color:
                                          C.bg.withOpacity(0.7))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                              const SubscriptionScreen())),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: C.gold.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(14),
                          border:
                          Border.all(color: C.gold.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('🛕',
                                style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 10),
                            Column(children: [
                              Text('Upgrade to Basic',
                                  style: cinzel(size: 13, color: C.gold,
                                      weight: FontWeight.bold)),
                              Text('All 30 temples + VR for ₹149/mo',
                                  style: lato(size: 11,
                                      color: C.white40)),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  Widget _paidVRPage(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('VR Darshan',
                      style: cinzel(size: 28, color: C.gold,
                          weight: FontWeight.w800)),
                  Text('Immersive Virtual Experiences',
                      style: lato(size: 13, color: C.white40)),
                  const SizedBox(height: 24),
                  Text('Quick VR Darshan',
                      style: cinzel(size: 14, color: C.gold,
                          weight: FontWeight.w700)),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 14,
              crossAxisSpacing: 14, childAspectRatio: 0.88,
            ),
            delegate: SliverChildBuilderDelegate(
                  (ctx, i) {
                final d = DestinationData.jammuTemples[i];
                return GestureDetector(
                  onTap: () => Navigator.push(ctx,
                      MaterialPageRoute(
                          builder: (_) =>
                              VRDarshanScreen(destination: d))),
                  child: Container(
                    decoration: BoxDecoration(
                      color: C.card,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: C.cardBorder),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(d.iconEmoji,
                            style: const TextStyle(fontSize: 42)),
                        const SizedBox(height: 10),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(d.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: cinzel(size: 11, color: C.white,
                                  weight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 4),
                        Text(d.region,
                            textAlign: TextAlign.center,
                            style:
                            lato(size: 10, color: d.accentColor)),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: C.teal.withOpacity(0.14),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: C.teal.withOpacity(0.35)),
                          ),
                          child: Text('🥽 VR Darshan',
                              style: lato(size: 10, color: C.teal,
                                  weight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount:
              DestinationData.jammuTemples.take(6).length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  PROFILE TAB
// ─────────────────────────────────────────────────────────────

class _ProfileTab extends StatefulWidget {
  const _ProfileTab();
  @override
  State<_ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<_ProfileTab> {
  String _name  = '';
  String _email = '';
  String _plan  = '';
  bool _vrAddon = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      _name   = p.getString('userName') ?? 'Explorer';
      _email  = p.getString('userEmail') ?? '';
      _plan   = p.getString('userPlan') ?? 'trial';
      _vrAddon= p.getBool('vrAddon') ?? false;
    });
  }

  PlanModel get _planModel {
    switch (_plan) {
      case 'basic':    return Plans.basic;
      case 'advanced': return Plans.advanced;
      case 'pro':      return Plans.pro;
      default:         return Plans.trial;
    }
  }

  Future<void> _logout() async {
    final p = await SharedPreferences.getInstance();
    await p.clear();
    if (!mounted) return;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final plan = _planModel;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [plan.color.withOpacity(0.22), C.bg],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 28),
                child: Column(
                  children: [
                    Container(
                      width: 90, height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [plan.color, plan.colorDark]),
                        boxShadow: [
                          BoxShadow(
                              color: plan.color.withOpacity(0.45),
                              blurRadius: 30,
                              spreadRadius: 4),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _name.isNotEmpty
                              ? _name[0].toUpperCase()
                              : 'E',
                          style: cinzel(size: 38, color: Colors.white,
                              weight: FontWeight.w900),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(_name,
                        style: cinzel(size: 24, color: C.white,
                            weight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(_email, style: lato(size: 13, color: C.white40)),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [plan.color, plan.colorDark]),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(plan.emoji,
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                              '${plan.name} Plan${_vrAddon ? ' + VR' : ''}',
                              style: cinzel(size: 13, color: Colors.white,
                                  weight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 22),
                Row(
                  children: [
                    _statCard(_plan == 'trial' ? '0' : '12',
                        'Destinations\nVisited', '🌍'),
                    const SizedBox(width: 12),
                    _statCard('7', 'VR\nSessions', '🥽'),
                    const SizedBox(width: 12),
                    _statCard('5', 'Reminders\nSet', '🔔'),
                  ],
                ),
                const SizedBox(height: 26),
                _sectionLabel('My Account'),
                _tile(Icons.edit_outlined, 'Edit Profile', null, () {}),
                _tile(Icons.notifications_outlined, 'Aarti Notifications', null, () {}),
                _tile(Icons.favorite_outline, 'Saved Places', null, () {}),
                const SizedBox(height: 16),
                _sectionLabel('Subscription'),
                _tile(Icons.workspace_premium_outlined, 'Current Plan', plan.name, () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => const SubscriptionScreen()));
                }, planColor: plan.color),
                _tile(Icons.upgrade_outlined, 'Upgrade Plan', null, () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => const SubscriptionScreen()));
                }, isHighlight: true),
                const SizedBox(height: 16),
                _sectionLabel('Support'),
                _tile(Icons.help_outline, 'Help & FAQ', null, () {}),
                _tile(Icons.privacy_tip_outlined, 'Privacy Policy', null, () {}),
                _tile(Icons.info_outline, 'About AnubhavX', 'v4.1', () {}),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _logout,
                    icon: const Icon(Icons.logout, color: Colors.red, size: 18),
                    label: Text('Sign Out',
                        style: cinzel(size: 13, color: Colors.red,
                            weight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  '© 2025 AnubhavX Technologies Pvt. Ltd.\nWorld Tourism & VR Experiences\nMade with ❤️ in India 🇮🇳',
                  textAlign: TextAlign.center,
                  style: lato(size: 10, color: C.white20, height: 1.8),
                ),
                const SizedBox(height: 110),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _statCard(String value, String label, String emoji) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: C.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: C.cardBorder),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 6),
          Text(value,
              style: cinzel(size: 20, color: C.gold,
                  weight: FontWeight.w800)),
          Text(label,
              textAlign: TextAlign.center,
              style: lato(size: 10, color: C.white40, height: 1.4)),
        ],
      ),
    ),
  );

  Widget _sectionLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(label,
          style: cinzel(size: 12, color: C.gold, weight: FontWeight.w700,
              spacing: 1)),
    ),
  );

  Widget _tile(IconData icon, String label, String? value,
      VoidCallback onTap, {bool isHighlight = false, Color? planColor}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isHighlight ? C.gold.withOpacity(0.07) : C.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: isHighlight
                    ? C.gold.withOpacity(0.28)
                    : C.cardBorder),
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: isHighlight
                      ? C.gold
                      : planColor ?? C.white40,
                  size: 20),
              const SizedBox(width: 14),
              Expanded(
                  child: Text(label,
                      style: lato(size: 14,
                          color: isHighlight ? C.gold : C.white,
                          weight: FontWeight.w500))),
              if (value != null) ...[
                Text(value, style: lato(size: 12, color: C.white40)),
                const SizedBox(width: 6),
              ],
              const Icon(Icons.chevron_right, color: C.white20, size: 18),
            ],
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────
//  TEMPLE VR SCREEN  (Unity Widget)
// ─────────────────────────────────────────────────────────────

class TempleVRScreen extends StatelessWidget {
  const TempleVRScreen({super.key});

  Future<void> _openVR(BuildContext context) async {
    final uri = Uri.parse('https://resplendent-hamster-25f454.netlify.app/');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open VR experience',
                style: lato(size: 13, color: C.white)),
            backgroundColor: C.saffron,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('VR Experience', style: cinzel(size: 16, color: C.teal)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🥽', style: TextStyle(fontSize: 80)),
              const SizedBox(height: 24),
              Text('AnubhavX VR Simulation',
                  textAlign: TextAlign.center,
                  style: cinzel(size: 22, color: C.white, weight: FontWeight.w800)),
              const SizedBox(height: 10),
              Text('Experience sacred temples in 360°',
                  textAlign: TextAlign.center,
                  style: lato(size: 13, color: C.white40)),
              const SizedBox(height: 36),
              GradientButton(
                onPressed: () => _openVR(context),
                colors: const [C.teal, C.tealDark],
                shadowColor: C.teal,
                height: 62,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🥽', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 12),
                    Text('Launch VR Experience',
                        style: cinzel(size: 14, color: C.bg, weight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ─────────────────────────────────────────────────────────────
//  ANDROID NATIVE: APK LAUNCHER (MainActivity.kt snippet)
// ─────────────────────────────────────────────────────────────
//
//  In android/app/src/main/kotlin/.../MainActivity.kt, add:
//
//  import io.flutter.embedding.android.FlutterActivity
//  import io.flutter.embedding.engine.FlutterEngine
//  import io.flutter.plugin.common.MethodChannel
//  import android.content.Intent
//  import android.net.Uri
//  import androidx.core.content.FileProvider
//  import java.io.File
//
//  class MainActivity : FlutterActivity() {
//    private val CHANNEL = "anubhavx/apk_launcher"
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//      super.configureFlutterEngine(flutterEngine)
//      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
//        .setMethodCallHandler { call, result ->
//          if (call.method == "launchAPK") {
//            val path = call.argument<String>("path") ?: return@setMethodCallHandler
//            val file = File(path)
//            val uri = FileProvider.getUriForFile(
//              this,
//              "${packageName}.fileprovider",
//              file
//            )
//            val intent = Intent(Intent.ACTION_VIEW).apply {
//              setDataAndType(uri, "application/vnd.android.package-archive")
//              addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
//              addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//            }
//            startActivity(intent)
//            result.success(null)
//          } else {
//            result.notImplemented()
//          }
//        }
//    }
//  }
//
//  Also add in android/app/src/main/res/xml/file_paths.xml:
//  <paths>
//    <cache-path name="cache" path="." />
//  </paths>
//
//  And in AndroidManifest.xml inside <application>:
//  <provider
//    android:name="androidx.core.content.FileProvider"
//    android:authorities="${applicationId}.fileprovider"
//    android:exported="false"
//    android:grantUriPermissions="true">
//    <meta-data
//      android:name="android.support.FILE_PROVIDER_PATHS"
//      android:resource="@xml/file_paths" />
//  </provider>