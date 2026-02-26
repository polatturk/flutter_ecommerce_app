import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/profile_page.dart'; 

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const EcommerceApp(),
    ),
  );
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onButtonPressed(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$name tıklandı!"),
        duration: const Duration(milliseconds: 500),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _goToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Üst Başlık
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hoş Geldin,", style: TextStyle(color: Colors.grey, fontSize: 16)),
                        Text("Yeni Ürünleri Keşfet", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    InkWell(
                      onTap: _goToProfile,
                      borderRadius: BorderRadius.circular(25),
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            
            // Çağırdığın ama tanımlanmamış olan metodlar:
            _buildSearchArea(),
            _buildCategories(),
            _buildProductGrid(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- Yardımcı Widget Metodları ---

  Widget _buildSearchArea() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Ürün ara...",
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: const Icon(Icons.search, color: Colors.deepPurple),
                onPressed: () => _onButtonPressed("Arama"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20),
          children: [
            _categoryItem("Hepsi", Icons.grid_view, true),
            _categoryItem("Elektronik", Icons.settings_input_component, false),
            _categoryItem("Moda", Icons.checkroom, false),
            _categoryItem("Ev", Icons.home_repair_service, false),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(String name, IconData icon, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSelected ? Colors.deepPurple : Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: isSelected ? Colors.white : Colors.black54),
          ),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _productCard(index),
          childCount: 4,
        ),
      ),
    );
  }

  Widget _productCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Ürün Adı", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("\$120.00", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(Icons.home_filled, 0, "Ana Sayfa"),
          _navItem(Icons.favorite_border, 1, "Favoriler"),
          _navItem(Icons.shopping_bag_outlined, 2, "Sepet"),
          _navItem(Icons.person_outline, 3, "Profil"),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index, String label) {
    bool isSelected = _selectedIndex == index;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.white : Colors.white54),
      onPressed: () {
        setState(() => _selectedIndex = index);
        if (index == 3) _goToProfile();
        else _onButtonPressed(label);
      },
    );
  }
}