import 'package:flutter/material.dart';




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
                  darkTeal,
                  mediumTeal,
                  lightAqua,
                  // lightBeige,
                  tanBrown,
                  
                ],
                stops: [0.0, 0.35, 0.65, 1.0],
              ),
            ),
          ),


          Positioned(
            top:-60,
            left: 0,
            right: 0,
            child: Center(
              child: Opacity(
                opacity: 0.2, // لتخفيف ظهور الشعار كخلفية
                child: Image.asset(
                  'assets/images/logo_buildings.png', // يُفترض أنك وضعت صورة الشعار (المباني فقط) في مجلد assets
                  height: 500,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

     
          const Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 150), // مسافة من الأعلى لـ Avatar
              child: ProfileCard(),
            ),
          ),

          const Positioned(
            top: 100,
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


class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: lightBeige,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
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
        size: 120,
        color: darkTeal,
      ),
    );
  }
}

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
        borderRadius: BorderRadius.circular(30.0),
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
        
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 40),
              Text(
                'Iman Ghabash',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkTeal),
              ),
             
              Icon(Icons.apartment, color: mediumTeal),
            ],
          ),
          const SizedBox(height: 15),

        
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

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton(
                icon: Icons.description,
                label: 'My Docs',
                color: mediumTeal,
              ),
              ActionButton(
                icon: Icons.calendar_month,
                label: 'My Bookings',
                color: mediumTeal,
              ),
            ],
          ),
          const SizedBox(height: 40),

      
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
               
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
            color: mediumTeal,
            size: 20,
          ),
      ],
    );
  }
}


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
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20.0),
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