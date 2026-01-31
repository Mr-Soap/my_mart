import 'package:flutter/material.dart';
import 'package:my_mart/components/intro_button.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              //Logo
              Image.asset('assets/images/shopping-cart.png', height: 250,),
        
              const SizedBox(height: 25),
          
              // Judul
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Belanja barang yang kamu butuhkan di Senja Mart',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
        
              const SizedBox(height: 10),
        
              //subJudul
              Text(
                'Toko Senja menyediakan produk premium yang berkelas\ndengan kualitas tinggi',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary.withAlpha(150),
                  fontWeight: FontWeight.w500
                ),
              ),
        
              const SizedBox(height: 30),
          
              //button
              IntroButton(
                onTap: () => Navigator.pushNamed(context, '/shop_page'),
                child:
                Text(
                  'Ayo Mulai',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}