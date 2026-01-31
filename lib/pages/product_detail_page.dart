import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mart/models/product.dart';
import 'package:my_mart/models/shop.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final formatter = NumberFormat('#,##0.00');
  bool isDescriptionExpanded = false;
  int count = 1;

  //function addcount
  void addCount() {
    count = count + 1;
    setState(() {});
  }

  //function removecount
  void removeCount() {
    if (count != 0) {
      count = count - 1;
      setState(() {});
    }
  }

  //function add to cart
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
              context.read<Shop>().addToCart(widget.product);
            },
            child: Text('yes'),
          ),
        ],
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT, // durasi
      gravity: ToastGravity.TOP, // posisi
      backgroundColor: Color.fromARGB(255, 216, 158, 0),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void moreText() {
    setState(() {
      isDescriptionExpanded = !isDescriptionExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detail Barang',
          style: GoogleFonts.inter(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          //ke cart button
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart_page'),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //product name
                  Text(
                    widget.product.name,
                    style: GoogleFonts.montserrat(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  //image product
                  Center(
                    child: Hero(
                      tag: widget.product.imagePath,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(widget.product.imagePath),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //slidebox
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Column(
                      children: [
                        //Harga + kuantitas
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //price
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'Rp. ${formatter.format(widget.product.price)}',
                              style: GoogleFonts.inter(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            //kategori
                            Text(
                              widget.product.category,
                              style: GoogleFonts.inter(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        //quantitas
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tersedia : ${widget.product.quantity} pcs',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        //deskripsi
                        Container(
                          padding: EdgeInsets.only(top: 25),
                          child: Text(
                            widget.product.description,
                            textAlign: TextAlign.justify,
                            maxLines: isDescriptionExpanded ? null : 3,
                            overflow: isDescriptionExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        //see more
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: moreText,
                            icon: Icon(
                              isDescriptionExpanded
                                  ? Icons.keyboard_double_arrow_up_rounded
                                  : Icons.keyboard_double_arrow_down_rounded,
                              color: const Color.fromARGB(255, 255, 147, 7),
                            ),
                            label: Text(
                              isDescriptionExpanded
                                  ? 'Tutup'
                                  : 'Lihat Selengkapnya',
                              style: GoogleFonts.inter(
                                color: const Color.fromARGB(255, 255, 147, 7),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        //specifications
                        if (widget.product.specifications != null &&
                            widget.product.specifications!.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    'Spesifikasi:',
                                    style: GoogleFonts.inter(
                                      color: Theme.of(context).colorScheme.inversePrimary,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ...widget.product.specifications!.entries.map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${entry.key}: ',
                                          style: GoogleFonts.inter(
                                            color: Theme.of(context).colorScheme.inversePrimary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            entry.value,
                                            style: GoogleFonts.inter(
                                              color: Theme.of(context).colorScheme.inversePrimary,
                                              fontSize: 18,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //button kuantitas
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.bottomCenter,
            color: Theme.of(context).colorScheme.inverseSurface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: removeCount,
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Text(
                        count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: addCount,
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),

                //button keranjang
                GestureDetector(
                  onTap: () {
                    //add to cart
                    context.read<Shop>().addToCartWithQuantity(
                      widget.product,
                      count,
                    );
                    showToast('Produk berhasil ditambahkan! ($count item)');
                  },
                  child: Container(
                    width: 230,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Tambah Keranjang',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
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