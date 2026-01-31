import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mart/components/home_drawer.dart';
import 'package:my_mart/components/home_product_tile.dart';
import 'package:my_mart/components/category_tile.dart';
import 'package:my_mart/models/category_controller.dart';
import 'package:my_mart/models/shop.dart';
import 'package:provider/provider.dart';
import 'package:my_mart/models/user.dart';
import 'package:my_mart/components/more_button.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final User user;

    //akses produk
    final products = context.watch<Shop>().shop;

    return Scaffold(
      drawer: const HomeDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 320,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0x80FFD93D),
                    Color(0x80FFE52A),
                    Color(0x80FF9A00),
                    Color(0x804F200D),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //appBar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                            builder: (context) => IconButton(
                              icon: const Icon(Icons.menu),
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                          ),
                          Text(
                            'SISISENJA.DUNIA',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/cart_page'),
                            icon: const Icon(Icons.shopping_cart),
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    //Title
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          'TOKO SENJA',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    //shop subtit
                    Center(
                      child: Text(
                        'Diambil dari barang barang premium terpiilih',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // white box
            Transform.translate(
              offset: const Offset(0, -40), // efek menimpa gradient
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),

                    //decor
                    Container(
                      height: 4,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary.withAlpha(80),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),

                    const SizedBox(height: 25),

                    //SearchBar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'cari',
                          suffixIcon: Icon(Icons.search),
                          suffixIconColor: Theme.of(
                            context,
                          ).colorScheme.inversePrimary,
                          hintStyle: GoogleFonts.inter(
                            color: Theme.of(
                              context,
                            ).colorScheme.inversePrimary.withAlpha(126),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Column(
                      children: [
                        //kategori
                        GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.8,
                              ),
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              category: dummyCategories[index],
                            );
                          },
                        ),

                        //more button
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            child: Center(
                              child: MoreButton(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //text
                                    Text(
                                      'Lihat lainnya',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),

                                    //icon
                                    Icon(
                                      Icons.keyboard_double_arrow_down_rounded,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    //for You
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.centerLeft,
                      child: Text(
                      'Rekomendasi untuk anda',
                      style: GoogleFonts.inter(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      ),
                    ),

                    //produk list
                    SizedBox(
                      height: 610,
                      child: ListView.builder(
                        itemCount: products.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return HomeProductTile(product: product);
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    //more button
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: Center(
                          child: MoreButton(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //text
                                Text(
                                  'Lihat lainnya',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                //icon
                                Icon(
                                  Icons.keyboard_double_arrow_right_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    //text
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Created by syifaSopian on 2026',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
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
}
