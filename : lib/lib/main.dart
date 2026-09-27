import 'package:flutter/material.dart';

void main() {
  runApp(const ElResalahApp());
}

class ElResalahApp extends StatelessWidget {
  const ElResalahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الرسالة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo', // خط عربي أنيق
        scaffoldBackgroundColor: const Color(0xFFF7F9F6), // أوف وايت هادئ جداً
        primaryColor: const Color(0xFF1B4332), // أخضر زيتي فخم
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // هيدر كرت متحرك للترحيب وآية يومية
              _buildHeaderCard(),
              const SizedBox(height: 30),
              const Text(
                'الأقسام الرئيسية',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 15),
              // شبكة الأزرار التفاعلية
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildAnimatedCategoryCard(
                      title: 'مواقيت الصلاة والقبلة',
                      icon: Icons.access_time_filled_rounded,
                      color: const Color(0xFF2D6A4F),
                      onTap: () {},
                    ),
                    _buildAnimatedCategoryCard(
                      title: 'أذكار المسلم اليومية',
                      icon: Icons.menu_book_rounded,
                      color: const Color(0xFF40916C),
                      onTap: () {},
                    ),
                    _buildAnimatedCategoryCard(
                      title: 'تذكير الصيام (الفرض والسنة)',
                      icon: Icons.calendar_today_rounded,
                      color: const Color(0xFF52B788),
                      onTap: () {},
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

  // كرت الهيدر الأنيق
  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B4332), Color(0xFF2D6A4F)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B4332).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: const [
          Text(
            'تطبيق الرسالة',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFD8F3DC)),
          ),
          SizedBox(height: 10),
          Text(
            '«عَلَيْكُمْ بِسُنَّتِي وَسُنَّةِ الْخُلَفَاءِ الرَّاشِدِينَ»',
            style: TextStyle(fontSize: 15, color: Colors.white70, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // زر تصنيف متفاعل مع الضغط بحركة سلسة
  Widget _buildAnimatedCategoryCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.15), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded, color: color, size: 18),
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(icon, color: color, size: 26),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
