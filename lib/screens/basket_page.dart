import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _CartPageState();
}

class _CartPageState extends State<BasketPage> {
  // Örnek sepet verisi (Backend'den gelecek yapıya uygun)
  List<Map<String, dynamic>> cartItems = [
    {"name": "Nike Air Max", "price": 120.00, "count": 1, "image": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400"},
    {"name": "Adidas Ultraboost", "price": 180.00, "count": 2, "image": "https://images.unsplash.com/photo-1587563871167-1ee9c731aefb?w=400"},
  ];

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item['price'] * item['count']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cartItems.isEmpty 
        ? _buildEmptyCart() 
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) => _buildCartItem(index),
                ),
              ),
              _buildCheckoutSection(),
            ],
          ),
    );
  }

  // Ürün Kartı
  Widget _buildCartItem(int index) {
    final item = cartItems[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(image: NetworkImage(item['image']), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Text("\₺${item['price']}", style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Miktar Kontrolü
          Column(
            children: [
              _quantityButton(Icons.add, () {
                setState(() => item['count']++);
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text("${item['count']}", style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              _quantityButton(Icons.remove, () {
                if (item['count'] > 1) {
                  setState(() => item['count']--);
                } else {
                  setState(() => cartItems.removeAt(index));
                }
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: Colors.black),
      ),
    );
  }

  // Ödeme ve Alt Bölüm
  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Toplam Tutar:", style: TextStyle(color: Colors.grey, fontSize: 16)),
                Text("\₺${totalPrice.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.deepPurple)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Ödemeye Geç", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_basket_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text("Sepetin Boş!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
        ],
      ),
    );
  }
}