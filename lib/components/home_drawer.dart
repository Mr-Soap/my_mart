import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mart/components/draw_list_tile.dart';
import 'package:my_mart/models/user_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Drawer(
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x80FFD93D),
              Color(0x80FFE52A),
              Color(0x80FF9A00),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                 // Drawer head
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: SizedBox(
                    child: Center(
                      child: Column(
                        children: [
                          //icon profile
                          Icon(
                            Icons.account_circle_rounded,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            size: 150,  
                          ),

                          //name
                          Text(
                            user?.username ?? 'Guest',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        
                const SizedBox(height: 25),
        
                //Profile setting
                DrawListTile(
                  text: 'Setting Profil',
                  icon: Icons.settings_rounded,
                  onTap: () {},
                ),

                //Shop Tile
                DrawListTile(
                  text: 'Toko',
                  icon: Icons.home,
                  onTap: () => Navigator.pop(context),
                ),
        
                //Cart Tile
                DrawListTile(
                  text: 'Keranjang',
                  icon: Icons.shopping_cart,
                  onTap: () {
                    //pop first
                    Navigator.pop(context);
        
                    //go to cart page
                    Navigator.pushNamed(context, '/cart_page');
                  }
                ),

                //kategori tile
                DrawListTile(
                  text: 'Kategori',
                  icon: Icons.category_outlined,
                  onTap: () {},
                ),

                //promo
                DrawListTile(
                  text: 'Promo',
                  icon: Icons.sell_rounded,
                  onTap: () {},
                ),

                //tentang
                DrawListTile(
                  text: 'Tentang Marketplace',
                  icon: Icons.help_outline_rounded,
                  onTap: () {},
                ),
        
                //login button
                if (user == null)
                  DrawListTile(
                    text: 'Login',
                    icon: Icons.login_rounded,
                    onTap: () {
                      //pop
                      Navigator.pop(context);

                      //go to login page
                      Navigator.pushNamed(context, '/login_page');
                    },
                  ),
              ],
            ),
            //exit Tile
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: DrawListTile(
                text: 'Exit',
                icon: Icons.logout,
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/intro_page', (route)=> false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}