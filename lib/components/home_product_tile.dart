import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mart/models/product.dart';
import 'package:my_mart/models/shop.dart';
import 'package:my_mart/pages/product_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class HomeProductTile extends StatelessWidget {
  final Product product;
  final NumberFormat formatter = NumberFormat('#,##0.00');

  HomeProductTile({super.key, required this.product});

  //add to cart button method
  void addToCart(BuildContext context) {
    //show dialogue box
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Tambahkan barang ini ke keranjang?'),
        actions: [
          // cancel
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'),
          ),

          // yes
          MaterialButton(
            onPressed: () {
              //pop dialogue
              Navigator.pop(context);

              //add to cart
              context.read<Shop>().addToCart(product);
            },
            child: Text('yes'),
          ),
        ],
      ),
    );
  }

  //Fungsi showtoast
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Color.fromARGB(255, 216, 158, 0),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            top: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 245, 205),
              Color.fromARGB(255, 255, 216, 158)
            ]
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(80),
              blurRadius: 6,
              spreadRadius: 1,
              offset: Offset(7, 4),
            ),
          ],
        ),
        margin: EdgeInsets.only(right: 30),
        width: 300,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // product image
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(product.imagePath),
                  ),
                ),

                const SizedBox(height: 25),

                //product name
                Text(
                  product.name,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 10),

                //quantity product
                Text(
                  'tersedia : ${product.quantity}',
                  style: GoogleFonts.inter(
                    fontSize: 14
                  ),
                ),

                const SizedBox(height: 10),

                //product description
                Text(
                  product.description,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.inter(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            
            const SizedBox(height: 25),

            //product price + add to cart button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //product prize
                // ignore: prefer_interpolation_to_compose_strings
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'Rp.${formatter.format(product.price)}',
                  style: GoogleFonts.inter(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),

                //tombol keranjang
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4F200D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {
                      //add to cart
                      context.read<Shop>().addToCart(product);
                      showToast('Produk berhasil ditambahkan!');
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
