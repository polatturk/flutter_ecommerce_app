import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Dinamik Header
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 31, 38, 46), Color.fromARGB(46, 95, 37, 133)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white24,
                      child: CircleAvatar(
                        radius: 42,
                        backgroundImage: NetworkImage(''),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("@polattturk.1", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Polat Türk", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),

          // Profil Menüleri
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildStatsRow(),
                  const SizedBox(height: 25),
                  _buildMenuCard([
                    _profileMenu("Siparişlerim", Icons.shopping_bag_outlined, Colors.blue),
                    _profileMenu("Adreslerim", Icons.location_on_outlined, Colors.orange),
                    _profileMenu("Ödeme Yöntemleri", Icons.payment_outlined, Colors.green),
                  ]),
                  const SizedBox(height: 20),
                  _buildMenuCard([
                    _profileMenu("Ayarlar", Icons.settings_outlined, Colors.grey),
                    _profileMenu("Yardım", Icons.help_outline, Colors.teal),
                    _profileMenu("Çıkış Yap", Icons.logout, Colors.red, isLogout: true),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statColumn("24", "Sipariş"),
        _statColumn("12", "Favori"),
        _statColumn("3", "Kupon"),
      ],
    );
  }

  Widget _statColumn(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(children: children),
    );
  }

  Widget _profileMenu(String title, IconData icon, Color color, {bool isLogout = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: isLogout ? Colors.red : Colors.black)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: () {},
    );
  }
}