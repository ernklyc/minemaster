// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:minemaster/ad_helper.dart';
import 'dart:math';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

enum Language { tr, en }

enum GameMode {
  easy(8, 8, 10), // 8x8 grid, 10 mayın
  medium(10, 10, 15), // 10x10 grid, 15 mayın
  hard(12, 12, 25); // 12x12 grid, 25 mayın

  final int rows;
  final int cols;
  final int mines;

  const GameMode(this.rows, this.cols, this.mines);
}

class AppLocalizations {
  static Language currentLanguage = Language.tr;

  static final Map<String, Map<String, String>> _localizedValues = {
    'tr': {
      'app_name': 'MF MASTER ONLINE',
      'game_description': 'Güçlendirilmiş Mayın Tarlası',
      'play': 'Oyuna Başla',
      'high_scores': 'Yüksek Skorlar',
      'how_to_play': 'Nasıl Oynanır?',
      'developer': 'Geliştirici',
      'basic_controls': 'Temel Kontroller',
      'basic_controls_desc':
          '• Güvenli kareyi açmak için dokun\n• Bayrak koymak icin uzun bas\n• Bayrak modunu açmak için alttaki butonu kullan',
      'number_meaning': 'Sayıların Anlamı',
      'number_meaning_desc':
          '• Sayılar çevredeki mayın sayısını gösterir\n• 1: Çevrede 1 mayın var\n• 2: Çevrede 2 mayın var\n• Boş kareler güvenli bölgeyi gösterir',
      'win_conditions': 'Kazanma Koşulları',
      'win_conditions_desc':
          '• Tüm güvenli kareleri aç\n• Mayınlara basmadan oyunu bitir\n• Hızlı bitir, yüksek skor yap!',
      'understand': 'Anladım',
      'close': 'Kapat',
      'no_scores': 'Henüz yüksek skor yok!',
      'seconds': 'saniye',
      'congratulations': 'Tebrikler!',
      'game_over': 'Oyun Bitti!',
      'you_won': 'Kazandınız!',
      'you_lost': 'Kaybettiniz!',
      'time': 'Süre',
      'best_score': 'En iyi skor',
      'play_again': 'Yeniden Başla',
      'flag_mode': 'Bayrak Modu',
      'flag_mode_on': 'Bayrak Modu Açık',
      'tutorial_title': 'Nasıl Oynanır?',
      'basic_controls_title': 'Temel Kontroller',
      'basic_controls_content':
          '• Güvenli kareyi açmak için dokun\n• Bayrak koymak için uzun bas\n• Bayrak modunu açmak icin alttaki butonu kullan',
      'numbers_title': 'Sayıların Anlamı',
      'numbers_content':
          '• Sayılar çevredeki mayın sayısını gösterir\n• 1: Çevrede 1 mayın var\n• 2: Çevrede 2 mayın var\n• Boş kareler güvenli bölgeyi gösterir',
      'win_title': 'Kazanma Koşulları',
      'win_content':
          '• Tüm güvenli kareleri aç\n• Mayınlara basmadan oyunu bitir\n• Hızlı bitir, yüksek skor yap!',
      'got_it': 'Anladım',
      'select_mode': 'Oyun Modu Seç',
      'mode_easy': 'Kolay',
      'mode_medium': 'Orta',
      'mode_hard': 'Zor',
      'mines': 'mayın',
      'menu': 'Ana Menü',
      'new_high_score': 'Yeni Yüksek Skor!',
      'developer_info': 'Geliştirici Bilgileri',
      'mode_easy_desc': '8x8 - 10 mayın',
      'mode_medium_desc': '10x10 - 15 mayın',
      'mode_hard_desc': '12x12 - 25 mayın',
      'high_scores_title': 'Yüksek Skorlar',
      'no_high_scores': 'Henüz yüksek skor yok!',
      'your_time': 'Süreniz',
      'best_time': 'En İyi Süre',
      'close_button': 'Kapat',
      'score_date': 'Tarih',
      'score_time': 'Süre',
      'play_offline': 'Oyuna Başla',
      'play_online': 'Online Oyna (Yakında)',
      'online_leaderboard': 'Online Sıralama',
      'your_rank': 'Sıralamanız',
      'rank': 'Sıra',
      'player': 'Oyuncu',
      'score': 'Skor',
      'play_online_soon': 'Online Mod Yakında!',
      'global_players': 'Tüm Oyuncular',
      'join_online': 'Online Oyuna Katıl',
      'coming_soon': 'Yakında...',
    },
    'en': {
      'app_name': 'MF MASTER ONLINE',
      'game_description': 'Enhanced Minesweeper',
      'play': 'Play Game',
      'high_scores': 'High Scores',
      'how_to_play': 'How to Play',
      'developer': 'Developer',
      'basic_controls': 'Basic Controls',
      'basic_controls_desc':
          '• Tap to reveal safe square\n• Long press to place flag\n• Use bottom button to toggle flag mode',
      'number_meaning': 'Number Meaning',
      'number_meaning_desc':
          '• Numbers show adjacent mines\n• 1: One mine nearby\n• 2: Two mines nearby\n• Empty squares are safe zones',
      'win_conditions': 'Win Conditions',
      'win_conditions_desc':
          '• Reveal all safe squares\n• Complete without hitting mines\n• Finish fast for high score!',
      'understand': 'Got it',
      'close': 'Close',
      'no_scores': 'No high scores yet!',
      'seconds': 'seconds',
      'congratulations': 'Congratulations!',
      'game_over': 'Game Over!',
      'you_won': 'You Won!',
      'you_lost': 'You Lost!',
      'time': 'Time',
      'best_score': 'Best Score',
      'play_again': 'Play Again',
      'flag_mode': 'Flag Mode',
      'flag_mode_on': 'Flag Mode On',
      'tutorial_title': 'How to Play?',
      'basic_controls_title': 'Basic Controls',
      'basic_controls_content':
          '• Tap to reveal safe square\n• Long press to place flag\n• Use bottom button to toggle flag mode',
      'numbers_title': 'Number Meaning',
      'numbers_content':
          '• Numbers show adjacent mines\n• 1: One mine nearby\n• 2: Two mines nearby\n• Empty squares are safe zones',
      'win_title': 'Win Conditions',
      'win_content':
          '• Reveal all safe squares\n• Complete without hitting mines\n• Finish fast for high score!',
      'got_it': 'Got it',
      'select_mode': 'Select Game Mode',
      'mode_easy': 'Easy',
      'mode_medium': 'Medium',
      'mode_hard': 'Hard',
      'mines': 'mines',
      'menu': 'Main Menu',
      'new_high_score': 'New High Score!',
      'developer_info': 'Developer Info',
      'mode_easy_desc': '8x8 - 10 mines',
      'mode_medium_desc': '10x10 - 15 mines',
      'mode_hard_desc': '12x12 - 25 mines',
      'high_scores_title': 'High Scores',
      'no_high_scores': 'No high scores yet!',
      'your_time': 'Your Time',
      'best_time': 'Best Time',
      'close_button': 'Close',
      'score_date': 'Date',
      'score_time': 'Time',
      'play_offline': 'Play Game',
      'play_online': 'Play Online (Coming Soon)',
      'online_leaderboard': 'Online Leaderboard',
      'your_rank': 'Your Rank',
      'rank': 'Rank',
      'player': 'Player',
      'score': 'Score',
      'play_online_soon': 'Online Mode Coming Soon!',
      'global_players': 'Global Players',
      'join_online': 'Join Online Game',
      'coming_soon': 'Coming Soon...',
    },
  };

  static String get(String key) {
    return _localizedValues[currentLanguage.toString().split('.').last]?[key] ??
        key;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await MobileAds.instance.initialize();
    debugPrint('MobileAds initialized successfully');
  } catch (e) {
    debugPrint('Error initializing MobileAds: $e');
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MinefieldApp());
}

class MinefieldApp extends StatelessWidget {
  const MinefieldApp({super.key});

  static const spotifyBlack = Color(0xFF191414);
  static const spotifyGreen = Color(0xFF1DB954);
  static const spotifyGrey = Color(0xFF282828);
  static const spotifyLightGrey = Color(0xFF404040);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MF Master Online',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: spotifyBlack,
        primaryColor: spotifyGreen,
        colorScheme: const ColorScheme.dark(
          primary: spotifyGreen,
          secondary: spotifyGrey,
          surface: spotifyGrey,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HighScore {
  final int time;
  final DateTime date;

  HighScore({required this.time, required this.date});

  Map<String, dynamic> toJson() => {
        'time': time,
        'date': date.toIso8601String(),
      };

  factory HighScore.fromJson(Map<String, dynamic> json) => HighScore(
        time: json['time'] as int,
        date: DateTime.parse(json['date'] as String),
      );
}

class Cell {
  final int row;
  final int col;
  bool isMine;
  bool isRevealed;
  bool isFlagged;
  int adjacentMines;

  Cell({
    required this.row,
    required this.col,
    this.isMine = false,
    this.isRevealed = false,
    this.isFlagged = false,
    this.adjacentMines = 0,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HighScore> highScores = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    await _loadHighScores();
  }

  Future<void> _loadHighScores() async {
    try {
      final scoresJson = prefs.getStringList('highScores') ?? [];
      setState(() {
        highScores = scoresJson
            .map((score) => HighScore.fromJson(jsonDecode(score)))
            .toList()
          ..sort((a, b) => a.time.compareTo(b.time));

        // En iyi 3 skoru al
        if (highScores.length > 3) {
          highScores = highScores.take(3).toList();
          // SharedPreferences'ı da güncelle
          final topScores =
              highScores.map((score) => jsonEncode(score.toJson())).toList();
          prefs.setStringList('highScores', topScores);
        }
      });
    } catch (e) {
      debugPrint('Error loading high scores: $e');
    }
  }

  void updateHighScores(List<HighScore> newScores) {
    setState(() {
      highScores = newScores;
    });
    // Yüksek skorları kaydet
    final scoresJson =
        highScores.map((score) => jsonEncode(score.toJson())).toList();
    prefs.setStringList('highScores', scoresJson);
    // Yüksek skorları yeniden yükle
    _loadHighScores();
    // Ekranı yenile
    setState(() {});
  }

  void _showTutorial() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MinefieldApp.spotifyGrey,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MinefieldApp.spotifyGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.help_outline,
                color: MinefieldApp.spotifyGreen,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.get('tutorial_title'),
              style: const TextStyle(
                color: MinefieldApp.spotifyGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTutorialSection(
                'basic_controls_title',
                'basic_controls_content',
                Icons.touch_app,
              ),
              const SizedBox(height: 16),
              _buildTutorialSection(
                'numbers_title',
                'numbers_content',
                Icons.numbers,
              ),
              const SizedBox(height: 16),
              _buildTutorialSection(
                'win_title',
                'win_content',
                Icons.emoji_events,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.get('got_it'),
              style: const TextStyle(
                color: MinefieldApp.spotifyGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorialSection(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MinefieldApp.spotifyGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: MinefieldApp.spotifyGreen.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MinefieldApp.spotifyGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: MinefieldApp.spotifyGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.get(title),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.get(content),
            style: TextStyle(
              color: Colors.grey[300],
              height: 1.5,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  void _showHighScores() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MinefieldApp.spotifyGrey,
        title: Row(
          children: [
            const Icon(Icons.emoji_events, color: MinefieldApp.spotifyGreen),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.get('high_scores_title'),
              style: const TextStyle(color: MinefieldApp.spotifyGreen),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: highScores.isEmpty
              ? Text(
                  AppLocalizations.get('no_high_scores'),
                  style: const TextStyle(color: Colors.grey),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: highScores.length,
                  itemBuilder: (context, index) {
                    final score = highScores[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: index == 0
                            ? MinefieldApp.spotifyGreen.withOpacity(0.2)
                            : Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                        border: index == 0
                            ? Border.all(color: MinefieldApp.spotifyGreen)
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? Colors.amber
                                  : index == 1
                                      ? Colors.grey[400]
                                      : Colors.brown[300],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${score.time} ${AppLocalizations.get("seconds")}',
                                style: TextStyle(
                                  color: index == 0
                                      ? MinefieldApp.spotifyGreen
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _formatDate(score.date),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.get('close_button'),
              style: const TextStyle(color: MinefieldApp.spotifyGreen),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  void _showGameModeDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: MinefieldApp.spotifyGrey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: MinefieldApp.spotifyGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.grid_4x4,
                    color: MinefieldApp.spotifyGreen,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.get('select_mode'),
                  style: const TextStyle(
                    color: MinefieldApp.spotifyGreen,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildModeButton(GameMode.easy, 'Kolay', '8x8'),
                const SizedBox(height: 12),
                _buildModeButton(GameMode.medium, 'Orta', '10x10'),
                const SizedBox(height: 12),
                _buildModeButton(GameMode.hard, 'Zor', '12x12'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton(GameMode mode, String title, String size) {
    String modeTitle;
    String modeDesc;

    switch (mode) {
      case GameMode.easy:
        modeTitle = AppLocalizations.get('mode_easy');
        modeDesc = AppLocalizations.get('mode_easy_desc');
        break;
      case GameMode.medium:
        modeTitle = AppLocalizations.get('mode_medium');
        modeDesc = AppLocalizations.get('mode_medium_desc');
        break;
      case GameMode.hard:
        modeTitle = AppLocalizations.get('mode_hard');
        modeDesc = AppLocalizations.get('mode_hard_desc');
        break;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MinefieldApp.spotifyBlack,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: MinefieldApp.spotifyGreen.withOpacity(0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameScreen(mode: mode),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  _getModeIcon(mode),
                  color: MinefieldApp.spotifyGreen,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        modeTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        modeDesc,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: MinefieldApp.spotifyGreen,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getModeIcon(GameMode mode) {
    switch (mode) {
      case GameMode.easy:
        return Icons.sentiment_satisfied;
      case GameMode.medium:
        return Icons.sentiment_neutral;
      case GameMode.hard:
        return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MinefieldApp.spotifyBlack,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: MinefieldApp.spotifyGreen.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.grid_4x4,
                        size: 48,
                        color: MinefieldApp.spotifyGreen,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Başlık
                    const Text(
                      'MF MASTER ONLINE',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: MinefieldApp.spotifyGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        AppLocalizations.get('game_description'),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Menü Butonları
                    _buildMenuButton(
                      AppLocalizations.get('play_offline'),
                      Icons.play_arrow,
                      _showGameModeDialog,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuButton(
                      AppLocalizations.get('play_online'),
                      Icons.wifi,
                      _showOnlineLeaderboard,
                      isDisabled: false,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuButton(
                      AppLocalizations.get('high_scores'),
                      Icons.emoji_events,
                      _showHighScores,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuButton(
                      AppLocalizations.get('how_to_play'),
                      Icons.help_outline,
                      _showTutorial,
                    ),
                    const SizedBox(height: 12),
                    _buildMenuButton(
                      AppLocalizations.get('developer'),
                      Icons.code,
                      _showDeveloperInfo,
                    ),
                    const SizedBox(height: 48),

                    // Dil değiştirme butonu
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          color: MinefieldApp.spotifyGrey,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: MinefieldApp.spotifyGreen,
                            width: 2,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              setState(() {
                                AppLocalizations.currentLanguage =
                                    AppLocalizations.currentLanguage ==
                                            Language.tr
                                        ? Language.en
                                        : Language.tr;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: Text(
                                AppLocalizations.currentLanguage == Language.tr
                                    ? 'TR'
                                    : 'EN',
                                style: const TextStyle(
                                  color: MinefieldApp.spotifyGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(String label, IconData icon, VoidCallback onPressed,
      {bool isDisabled = false}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: MinefieldApp.spotifyGreen,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: MinefieldApp.spotifyGreen.withOpacity(0.5),
          disabledForegroundColor: Colors.white.withOpacity(0.5),
        ),
        icon: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showDeveloperInfo() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: MinefieldApp.spotifyGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MinefieldApp.spotifyGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.code,
                  color: MinefieldApp.spotifyGreen,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.get('developer'),
                style: const TextStyle(
                  color: MinefieldApp.spotifyGreen,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MinefieldApp.spotifyBlack,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildDeveloperInfoRow(
                      Icons.person,
                      'Eren KALAYCI\nYelbegen Software',
                    ),
                    const Divider(color: Colors.grey),
                    _buildDeveloperInfoRow(
                      Icons.email,
                      'ernklyc@gmail.com',
                    ),
                    const Divider(color: Colors.grey),
                    _buildDeveloperInfoRow(
                      Icons.link,
                      'Google Play Store',
                      isLink: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: MinefieldApp.spotifyBlack,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppLocalizations.get('close'),
                  style: const TextStyle(
                    color: MinefieldApp.spotifyGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperInfoRow(IconData icon, String text,
      {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: MinefieldApp.spotifyGreen,
            size: 20,
          ),
          const SizedBox(width: 12),
          isLink
              ? GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(
                        'https://play.google.com/store/apps/dev?id=6576291249346115918&hl=tr');
                    try {
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      }
                    } catch (e) {
                      debugPrint('Error launching URL: $e');
                    }
                  },
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: MinefieldApp.spotifyGreen,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
        ],
      ),
    );
  }

  void _showOnlineLeaderboard() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: MinefieldApp.spotifyGrey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Başlık ve geri butonu
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MinefieldApp.spotifyGreen.withOpacity(0.1),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.get('online_leaderboard'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Alt başlık
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.get('global_players'),
                  style: const TextStyle(color: Colors.grey),
                ),
              ),

              // Sıralama başlıkları
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        AppLocalizations.get('rank'),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppLocalizations.get('player'),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(
                        AppLocalizations.get('score'),
                        style: const TextStyle(color: Colors.grey),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),

              // Sıralama listesi (örnek veriler)
              Expanded(
                child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: MinefieldApp.spotifyBlack,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Text(
                              '#${index + 1}',
                              style: TextStyle(
                                color: index < 3
                                    ? MinefieldApp.spotifyGreen
                                    : Colors.grey,
                                fontWeight: index < 3
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Player ${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                            child: Text(
                              '---',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Kendi sıralaması
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MinefieldApp.spotifyBlack,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.get('your_rank'),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '#---',
                          style: TextStyle(
                            color: MinefieldApp.spotifyGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: null, // Devre dışı
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            MinefieldApp.spotifyGreen.withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.play_arrow),
                          const SizedBox(width: 8),
                          Text(AppLocalizations.get('coming_soon')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didPopNext() {
    _loadHighScores();
  }
}

class GameScreen extends StatefulWidget {
  final GameMode mode;

  const GameScreen({
    super.key,
    required this.mode,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<Cell>> _grid;
  late int _rows;
  late int _cols;
  late int _mines;
  late int _flags;
  late int _safeCells;
  late int _time;
  late Timer _timer;
  late bool _isGameOver;
  late bool _isGameWon;
  late bool _isFlagMode;
  List<HighScore> highScores = [];
  late SharedPreferences prefs;
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  BannerAd? _bottomBannerAd;
  bool _isBottomBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    _loadHighScores();
    _initializeGame();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    try {
      // Üst banner reklam
      _bannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              _isBannerAdReady = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            debugPrint('Failed to load banner ad: ${err.message}');
            _isBannerAdReady = false;
            ad.dispose();
          },
        ),
      );

      // Alt banner reklam
      _bottomBannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              _isBottomBannerAdReady = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            debugPrint('Failed to load bottom banner ad: ${err.message}');
            _isBottomBannerAdReady = false;
            ad.dispose();
          },
        ),
      );

      _bannerAd?.load();
      _bottomBannerAd?.load();
    } catch (e) {
      debugPrint('Error creating banner ads: $e');
    }
  }

  Future<void> _loadHighScores() async {
    try {
      prefs = await SharedPreferences.getInstance();
      final scoresJson = prefs.getStringList('highScores') ?? [];

      setState(() {
        highScores = scoresJson
            .map((score) => HighScore.fromJson(jsonDecode(score)))
            .toList()
          ..sort((a, b) => a.time.compareTo(b.time));

        // En iyi 3 skoru al
        if (highScores.length > 3) {
          highScores = highScores.take(3).toList();
          // SharedPreferences'ı da güncelle
          final topScores =
              highScores.map((score) => jsonEncode(score.toJson())).toList();
          prefs.setStringList('highScores', topScores);
        }
      });
    } catch (e) {
      debugPrint('Error loading high scores: $e');
    }
  }

  Future<void> _saveHighScore(int time) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentScores = prefs.getStringList('highScores') ?? [];

      // Mevcut skorları yükle ve sırala
      final scores = currentScores
          .map((score) => HighScore.fromJson(jsonDecode(score)))
          .toList()
        ..sort((a, b) => a.time.compareTo(b.time));

      // Yeni skoru ekle
      final newScore = HighScore(
        time: time,
        date: DateTime.now(),
      );

      scores.add(newScore);
      scores.sort((a, b) => a.time.compareTo(b.time));

      // En iyi 3 skoru al
      final topScores = scores.take(3).map((score) => jsonEncode(score.toJson())).toList();
      await prefs.setStringList('highScores', topScores);

      // HomeScreen'deki yüksek skorları güncelle
      if (context.mounted) {
        final homeScreenState = context.findAncestorStateOfType<_HomeScreenState>();
        if (homeScreenState != null) {
          // Ana ekranı hemen güncelle
          setState(() {
            highScores = scores.take(3).toList();
          });
          homeScreenState.setState(() {
            homeScreenState.highScores = scores.take(3).toList();
          });
        }
      }

      // Oyunu bitir ve dialog'u göster
      _isGameOver = true;
      _isGameWon = true;
      _timer.cancel();

      if (context.mounted) {
        _showGameOverDialog(true);
      }
    } catch (e) {
      debugPrint('Error saving high score: $e');
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _bottomBannerAd?.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _initializeGame() {
    _rows = widget.mode.rows;
    _cols = widget.mode.cols;
    _mines = widget.mode.mines;
    _flags = _mines;
    _safeCells = (_rows * _cols) - _mines;
    _time = 0;
    _isGameOver = false;
    _isGameWon = false;
    _isFlagMode = false;

    _grid = List.generate(
      _rows,
      (row) => List.generate(
        _cols,
        (col) => Cell(row: row, col: col),
      ),
    );

    _placeMines();
    _calculateAdjacentMines();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isGameOver && !_isGameWon) {
        setState(() {
          _time++;
        });
      }
    });
  }

  void _placeMines() {
    final random = Random();
    var minesPlaced = 0;

    while (minesPlaced < _mines) {
      final row = random.nextInt(_rows);
      final col = random.nextInt(_cols);

      if (!_grid[row][col].isMine) {
        _grid[row][col].isMine = true;
        minesPlaced++;
      }
    }
  }

  void _calculateAdjacentMines() {
    for (var row = 0; row < _rows; row++) {
      for (var col = 0; col < _cols; col++) {
        if (!_grid[row][col].isMine) {
          _grid[row][col].adjacentMines = _countAdjacentMines(row, col);
        }
      }
    }
  }

  int _countAdjacentMines(int row, int col) {
    var count = 0;

    for (var i = -1; i <= 1; i++) {
      for (var j = -1; j <= 1; j++) {
        final newRow = row + i;
        final newCol = col + j;

        if (newRow >= 0 &&
            newRow < _rows &&
            newCol >= 0 &&
            newCol < _cols &&
            _grid[newRow][newCol].isMine) {
          count++;
        }
      }
    }

    return count;
  }

  void _revealCell(int row, int col) {
    if (_isGameOver ||
        _isGameWon ||
        _grid[row][col].isRevealed ||
        _grid[row][col].isFlagged) {
      return;
    }

    setState(() {
      _grid[row][col].isRevealed = true;

      if (_grid[row][col].isMine) {
        _isGameOver = true;
        _timer.cancel();
        _revealAllMines();
        _showGameOverDialog(false);
      } else {
        _safeCells--;
        if (_grid[row][col].adjacentMines == 0) {
          _revealAdjacentCells(row, col);
        }

        if (_safeCells == 0) {
          _saveHighScore(_time);
        }
      }
    });
  }

  void _revealAllMines() {
    for (var row = 0; row < _rows; row++) {
      for (var col = 0; col < _cols; col++) {
        if (_grid[row][col].isMine) {
          _grid[row][col].isRevealed = true;
        }
      }
    }
  }

  void _revealAdjacentCells(int row, int col) {
    for (var i = -1; i <= 1; i++) {
      for (var j = -1; j <= 1; j++) {
        final newRow = row + i;
        final newCol = col + j;

        if (newRow >= 0 &&
            newRow < _rows &&
            newCol >= 0 &&
            newCol < _cols &&
            !_grid[newRow][newCol].isRevealed &&
            !_grid[newRow][newCol].isMine) {
          _revealCell(newRow, newCol);
        }
      }
    }
  }

  void _toggleFlag(int row, int col) {
    if (_isGameOver || _isGameWon || _grid[row][col].isRevealed) return;

    setState(() {
      if (_grid[row][col].isFlagged) {
        _grid[row][col].isFlagged = false;
        _flags++;
      } else if (_flags > 0) {
        _grid[row][col].isFlagged = true;
        _flags--;
      }
    });
  }

  void _showGameOverDialog(bool isWin) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              color: MinefieldApp.spotifyGrey,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: MinefieldApp.spotifyGreen.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: isWin
                              ? MinefieldApp.spotifyGreen.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Icon(
                        isWin ? Icons.emoji_events : Icons.close,
                        color: isWin ? MinefieldApp.spotifyGreen : Colors.red,
                        size: 32,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isWin
                        ? AppLocalizations.get('congratulations')
                        : AppLocalizations.get('game_over'),
                    style: TextStyle(
                      color: isWin ? MinefieldApp.spotifyGreen : Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isWin
                        ? AppLocalizations.get('you_won')
                        : AppLocalizations.get('you_lost'),
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: MinefieldApp.spotifyBlack,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer,
                          color: isWin ? MinefieldApp.spotifyGreen : Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$_time ${AppLocalizations.get('seconds')}',
                          style: TextStyle(
                            color:
                                isWin ? MinefieldApp.spotifyGreen : Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isWin && highScores.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: MinefieldApp.spotifyGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.emoji_events,
                            color: MinefieldApp.spotifyGreen,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${AppLocalizations.get('best_score')}: ${highScores.first.time} ${AppLocalizations.get('seconds')}',
                            style: const TextStyle(
                              color: MinefieldApp.spotifyGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final homeScreenState = context.findAncestorStateOfType<_HomeScreenState>();
                            if (homeScreenState != null) {
                              // Ana ekrana dönmeden önce yüksek skorları güncelle
                              await homeScreenState._loadHighScores();
                              homeScreenState.setState(() {});
                            }
                            // Ana ekrana dön
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey[600]!),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.get('menu'),
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final homeScreenState = context.findAncestorStateOfType<_HomeScreenState>();
                            if (homeScreenState != null) {
                              // Yeniden başlamadan önce yüksek skorları güncelle
                              await homeScreenState._loadHighScores();
                              homeScreenState.setState(() {});
                            }
                            // Dialog'u kapat ve oyunu yeniden başlat
                            Navigator.pop(context);
                            setState(() {
                              _initializeGame();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MinefieldApp.spotifyGreen,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.get('play_again'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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

  Color _getNumberColor(int number) {
    switch (number) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      case 4:
        return Colors.purple;
      default:
        return Colors.orange;
    }
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      )) {
        throw Exception('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final gridSize = min(screenSize.width * 0.9, screenSize.height * 0.6);

    return Scaffold(
      backgroundColor: MinefieldApp.spotifyBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: MinefieldApp.spotifyGreen,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                MinefieldApp.spotifyGrey.withOpacity(0.95),
                MinefieldApp.spotifyGrey.withOpacity(0.9),
              ],
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInfoContainer(
                Icons.timer, '$_time ${AppLocalizations.get("seconds")}'),
            const SizedBox(width: 12),
            _buildInfoContainer(Icons.flag, '$_flags'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.link,
              color: MinefieldApp.spotifyGreen,
            ),
            onPressed: () => _launchURL(
                'https://play.google.com/store/apps/dev?id=6576291249346115918&hl=tr'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Üst reklam için sabit alan
            Container(
              height: 50, // Banner reklam yüksekliği
              alignment: Alignment.center,
              child: _isBannerAdReady
                  ? Container(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    )
                  : const SizedBox.shrink(), // Reklam yokken boş alan
            ),

            // Oyun alanı
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      MinefieldApp.spotifyBlack,
                      MinefieldApp.spotifyBlack.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: gridSize,
                        height: gridSize,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _cols,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                          ),
                          itemCount: _rows * _cols,
                          itemBuilder: (context, index) {
                            final row = index ~/ _cols;
                            final col = index % _cols;
                            final cell = _grid[row][col];

                            return Container(
                              margin: const EdgeInsets.all(1.5),
                              decoration: BoxDecoration(
                                color: cell.isRevealed
                                    ? (cell.isMine
                                        ? Colors.red.withOpacity(0.9)
                                        : MinefieldApp.spotifyLightGrey
                                            .withOpacity(0.95))
                                    : MinefieldApp.spotifyGrey
                                        .withOpacity(0.95),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: cell.isFlagged
                                      ? MinefieldApp.spotifyGreen
                                      : Colors.black.withOpacity(0.1),
                                  width: cell.isFlagged ? 2 : 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () {
                                    if (_isFlagMode) {
                                      _toggleFlag(row, col);
                                    } else {
                                      _revealCell(row, col);
                                    }
                                    HapticFeedback.lightImpact();
                                  },
                                  onLongPress: () {
                                    _toggleFlag(row, col);
                                    HapticFeedback.mediumImpact();
                                  },
                                  child: Center(
                                    child: cell.isRevealed
                                        ? (cell.isMine
                                            ? const Icon(Icons.close,
                                                color: Colors.white, size: 20)
                                            : (cell.adjacentMines > 0
                                                ? Text(
                                                    '${cell.adjacentMines}',
                                                    style: TextStyle(
                                                      color: _getNumberColor(
                                                          cell.adjacentMines),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      shadows: [
                                                        Shadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          blurRadius: 1,
                                                          offset: const Offset(
                                                              0.5, 0.5),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : null))
                                        : (cell.isFlagged
                                            ? Icon(
                                                Icons.flag,
                                                color:
                                                    MinefieldApp.spotifyGreen,
                                                size: 18,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    blurRadius: 1,
                                                    offset:
                                                        const Offset(0.5, 0.5),
                                                  ),
                                                ],
                                              )
                                            : null),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isFlagMode = !_isFlagMode;
                            });
                            HapticFeedback.mediumImpact();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isFlagMode
                                ? MinefieldApp.spotifyGreen
                                : MinefieldApp.spotifyGrey,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.flag,
                                color: _isFlagMode
                                    ? Colors.white
                                    : MinefieldApp.spotifyGreen,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _isFlagMode
                                    ? AppLocalizations.get('flag_mode_on')
                                    : AppLocalizations.get('flag_mode'),
                                style: TextStyle(
                                  color: _isFlagMode
                                      ? Colors.white
                                      : Colors.grey[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Alt reklam için sabit alan
            Container(
              height: 50, // Banner reklam yüksekliği
              alignment: Alignment.center,
              child: _isBottomBannerAdReady
                  ? Container(
                      width: _bottomBannerAd!.size.width.toDouble(),
                      height: _bottomBannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bottomBannerAd!),
                    )
                  : const SizedBox.shrink(), // Reklam yokken boş alan
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: MinefieldApp.spotifyBlack,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: MinefieldApp.spotifyGreen.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: MinefieldApp.spotifyGreen,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
