import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elite Escape Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileScreen(),
    );
  }
}

// تعريف الألوان بناءً على لوحة الألوان المقدمة
// HEX: #285260 (Dark Teal)
// HEX: #5A9C92 (Medium Teal)
// HEX: #B4D7D8 (Light Teal/Aqua)
// HEX: #E0CFBF (Light Beige)
// HEX: #AA8872 (Brown/Tan)

const Color darkTeal = Color(0xFF285260);
const Color mediumTeal = Color(0xFF5A9C92);
const Color lightAqua = Color(0xFFB4D7D8);
const Color lightBeige = Color(0xFFE0CFBF);
const Color tanBrown = Color(0xFFAA8872);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام Stack لوضع بطاقة المحتوى فوق الخلفية المتدرجة
    return Scaffold(
      body: Stack(
        children: [
          // 1. الخلفية المتدرجة (Gradient Background)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  darkTeal, // لون علوي مقارب للون الداكن في الباليت
                  mediumTeal,
                  lightAqua,
                  lightBeige, // لون سفلي مقارب للون البيج في الباليت
                ],
                stops: [0.0, 0.35, 0.65, 1.0], // توزيع الألوان في الخلفية
              ),
            ),
          ),

          // 2. تراكب المباني (الشعار كـ Overlay) - اختياري لجمالية التصميم
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Opacity(
                opacity: 0.2, // لتخفيف ظهور الشعار كخلفية
                child: Image.asset(
                  'assets/logo_buildings.png', // يُفترض أنك وضعت صورة الشعار (المباني فقط) في مجلد assets
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 3. المحتوى الرئيسي (بطاقة الملف الشخصي)
          const Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 150), // مسافة من الأعلى لـ Avatar
              child: ProfileCard(),
            ),
          ),

          // 4. صورة Avatar في المنتصف ومستوى أعلى
          const Positioned(
            top: 100, // تحديد موقع الـ Avatar فوق البطاقة
            left: 0,
            right: 0,
            child: Center(
              child: ProfileAvatar(),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------
// مكون Avatar
// ------------------------------------------------------------------
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: lightBeige, // خلفية Avatar فاتحة
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4), // إطار أبيض
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Icon(
        Icons.person,
        size: 60,
        color: darkTeal,
      ),
    );
  }
}

// ------------------------------------------------------------------
// بطاقة المحتوى الرئيسية
// ------------------------------------------------------------------
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      padding: const EdgeInsets.all(25.0),
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0), // حواف مدورة
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // عنوان و Logo صغير
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 40), // لترك مسافة للـ Avatar
              Text(
                'Iman Ghabash',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkTeal),
              ),
              // Logo/Icon صغير للمالك/الدور
              Icon(Icons.apartment, color: mediumTeal),
            ],
          ),
          const SizedBox(height: 15),

          // معلومات الاتصال
          const ContactInfoRow(
            icon: Icons.phone,
            text: '+963 998865316',
            color: darkTeal,
            isVerified: true,
          ),
          const SizedBox(height: 10),
          const ContactInfoRow(
            icon: Icons.mail,
            text: 'immanghabash -',
            color: darkTeal,
            isVerified: true,
          ),
          const Divider(height: 30, color: lightAqua),

          // أزرار الإجراءات (My Docs, My Bookings)
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton(
                icon: Icons.description,
                label: 'myDocs',
                color: mediumTeal,
              ),
              ActionButton(
                icon: Icons.calendar_month,
                label: 'my Bookings',
                color: mediumTeal,
              ),
            ],
          ),
          const SizedBox(height: 40),

          // زر تسجيل الخروج
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                // منطق تسجيل الخروج
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkTeal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------
// مكون صف معلومات الاتصال
// ------------------------------------------------------------------
class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final bool isVerified;

  const ContactInfoRow({
    required this.icon,
    required this.text,
    required this.color,
    this.isVerified = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: mediumTeal, size: 28),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: color),
          ),
        ),
        if (isVerified)
          const Icon(
            Icons.check_circle,
            color: mediumTeal, // استخدام لون الـ Teal للتحقق
            size: 20,
          ),
      ],
    );
  }
}

// ------------------------------------------------------------------
// مكون زر الإجراءات (My Docs / My Bookings)
// ------------------------------------------------------------------
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // منطق النقر على الزر
      },
      child: Container(
        width: 120, // لتحديد حجم مناسب
        height: 120,
        decoration: BoxDecoration(
          color: color.withOpacity(0.8), // لون الخلفية للزر
          borderRadius: BorderRadius.circular(20.0), // حواف مدورة
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}