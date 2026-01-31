import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mart/components/intro_button.dart';
import 'package:my_mart/models/product.dart';
import 'package:my_mart/models/shop.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //formatter
  final formatter = NumberFormat('#,##0.00');

  //remove function
  void removeItemFromCart(BuildContext context, Product item) {
    //show dialogue box
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Hapus produk dari keranjang?'),
        actions: [
          // cancel
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('cancel'),
          ),

          // yes
          MaterialButton(
            onPressed: () {
              //pop dialogue
              Navigator.pop(context);

              //remove from cart
              context.read<Shop>().removeItemCompletely(item);
            },
            child: Text('yes'),
          ),
        ],
      ),
    );
  }

  //pay button method
  void payButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          'Pelanggan ingin membayar! hubungkan aplikasi ini ke Backend Pembayaran',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //akses keranjang
    final cart = context.watch<Shop>().cart;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        title: Text(
          'Keranjang',
          style: GoogleFonts.inter(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          //ifelse
          Expanded(
            child: cart.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 150,
                          color: Theme.of(context).colorScheme.inversePrimary.withAlpha(150),
                        ),

                        SizedBox(height: 10),

                        Text(
                          textAlign: TextAlign.center,
                          'Keranjangmu kosong\nayo belanja!',
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.inversePrimary.withAlpha(150),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      //list item
                      Expanded(
                        child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            // get item
                            final item = cart[index];

                            //return ui
                            return ListTile(
                              // gambar
                              leading: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  child: Image.asset(item.imagePath),
                                ),
                              ),

                              //product detail
                              title: Text(
                                item.name,
                                style: GoogleFonts.inter(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.inversePrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              //harga
                              subtitle: Text(
                                'Rp.${formatter.format(item.price)}',
                                style: GoogleFonts.inter(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.inversePrimary.withAlpha(150),
                                ),
                              ),
                              trailing: SizedBox(
                                width: 155,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //tombol kurang
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                      ),
                                      onPressed: () => context
                                          .read<Shop>()
                                          .removeFromCart(item),
                                    ),

                                    //jumlah
                                    Text(
                                      '${item.cartQuantity}',
                                      style: GoogleFonts.inter(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    //tombol tambah
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                      ),
                                      onPressed: () =>
                                          context.read<Shop>().addToCart(item),
                                    ),

                                    //tombol hapus
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                      ),
                                      onPressed: () =>
                                          removeItemFromCart(context, item),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      //pay button
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: IntroButton(
                          onTap: () => payButtonPressed(context),
                          child: Text(
                            textAlign: TextAlign.center,
                            'BAYAR SEKARANG',
                            style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.surface,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
