import 'package:flutter/material.dart';
import 'package:my_mart/components/login_textfield.dart';
import 'package:my_mart/components/signin_button.dart';
import 'package:my_mart/components/square_tile.dart';
import 'package:my_mart/models/login_service.dart';
import 'package:my_mart/models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginService loginService = LoginService();

  void signUserIn() async {
    try {
      final user = await loginService.login(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      if (!mounted) return;

      if (user != null) {
        context.read<UserProvider>().setUser(user);
        Navigator.pushReplacementNamed(context, '/shop_page');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau password salah')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SizedBox(
              height: MediaQuery.of(context).size.height
                  - MediaQuery.of(context).padding.top,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //logo
                    Image.asset(
                      'assets/images/sisenja.png',
                      height: 220,
                    ),

                    const SizedBox(height: 25),

                    //smart people
                    Text(
                      'Halo Pelanggan Smart,\nSelamat Datang di Senja Mart',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context)
                            .colorScheme
                            .inversePrimary,
                      ),
                    ),

                    const SizedBox(height: 25),

                    //username field
                    LogTextfield(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false,
                    ),

                    const SizedBox(height: 12),

                    //password field
                    LogTextfield(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),

                    //forgot
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Lupa Password?',
                          style: GoogleFonts.inter(
                            color: Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withAlpha(160),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    //signin button
                    SigninButton(onTap: signUserIn),

                    const SizedBox(height: 40),

                    //continue with
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withAlpha(160),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Atau Lanjutkan dengan',
                            style: GoogleFonts.inter(
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary
                                  .withAlpha(160),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withAlpha(160),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    //google or apple
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SquareTile(imagePath: 'assets/images/google.png'),
                        SizedBox(width: 25),
                        SquareTile(imagePath: 'assets/images/apple.png'),
                      ],
                    ),

                    const SizedBox(height: 40),

                    //not a member
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bukan member?',
                          style: GoogleFonts.inter(
                            color: Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withAlpha(160),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Daftar Sekarang',
                          style: GoogleFonts.inter(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
