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
  String _selectedCategoryName = "Hepsi"; 

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
            _buildSearchArea(),
            _buildCategories(),
            _buildProductGrid(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

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
        height: 110,
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20),
          physics: const BouncingScrollPhysics(), 
          children: [
            _categoryItem("Hepsi", Icons.grid_view),
            _categoryItem("Elektronik", Icons.settings_input_component),
            _categoryItem("Moda", Icons.checkroom),
            _categoryItem("Ev", Icons.home_repair_service),
            _categoryItem("Kozmetik", Icons.auto_fix_high),
            _categoryItem("Spor", Icons.fitness_center),
            _categoryItem("Kitap", Icons.menu_book),
            _categoryItem("Oyuncak", Icons.smart_toy),
            _categoryItem("Mutfak", Icons.restaurant),
            _categoryItem("Bahçe", Icons.local_florist),
            _categoryItem("Pet Shop", Icons.pets),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(String name, IconData icon) {
    bool isSelected = _selectedCategoryName == name; 
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedCategoryName = name);
          _onButtonPressed(name);
        },
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isSelected ? Colors.deepPurple : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: isSelected 
                  ? [BoxShadow(color: Colors.deepPurple.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]
                  : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
              ),
              child: Icon(icon, color: isSelected ? Colors.white : Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(name, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
          ],
        ),
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
          childAspectRatio: 0.7, // Butonlar için boyutu biraz uzattık
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
            child: Stack(
              children: [
                // Ürün Görseli
                Container(
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
                // Favorilere Ekle (Kalp) Butonu
                Positioned(
                  top: 15,
                  right: 15,
                  child: InkWell(
                    onTap: () => _onButtonPressed("Favorilere eklendi"),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite_border, color: Colors.red, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nike Air Max", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("\₺120.00", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 16)),
                    InkWell(
                      onTap: () => _onButtonPressed("Sepete eklendi"),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.local_mall_outlined, color: Colors.white, size: 18),                      ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
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
          _navItem(Icons.home_filled, 0),
          _navItem(Icons.favorite_border, 1),
          _navItem(Icons.shopping_bag_outlined, 2),
          _navItem(Icons.person_outline, 3),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return IconButton(
      icon: Icon(icon, color: isSelected ? Colors.white : Colors.white54),
      onPressed: () {
        setState(() => _selectedIndex = index);
        if (index == 3) _goToProfile();
      },
    );
  }
}