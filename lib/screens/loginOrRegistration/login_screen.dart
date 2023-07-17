import 'dart:async';
import 'package:ski_resorts_app/code/screens/onboarding/onboarding_screen.dart';
import 'package:ski_resorts_app/old_screens/statistics/user_statistic_screen.dart';
import 'package:ski_resorts_app/screens/loginOrRegistration/data_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;
    late Timer splashTimeout = Timer(const Duration(milliseconds: 5000), () {});
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            //to give space card from top
            const Expanded(
              flex: 1,
              child: Center(),
            ),

            //page content
            Expanded(
              flex: 11,
              child: buildCard(context, size, _emailController,
                  _passwordController, isPressed, splashTimeout, setState),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCard(
    BuildContext context,
    Size size,
    TextEditingController emailController,
    TextEditingController passwordController,
    bool isPressed,
    Timer splashTimeout,
    var callback) {
  return Container(
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //build minimize icon
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 35,
              height: 4.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),

          //welcome text
          Text(
            'Welcome Back!',
            style: GoogleFonts.inter(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            'Let’s login for explore your skiing progress',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: const Color(0xFF969AA8),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),

          //logo section
          logo(size.height / 12, size.height / 12),
          SizedBox(
            height: size.height * 0.02,
          ),
          richText(24),
          SizedBox(
            height: size.height * 0.03,
          ),

          //email textField
          Text(
            'Email or Phone Number',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          emailTextField(size, emailController),
          SizedBox(
            height: size.height * 0.02,
          ),

          //password textField
          Text(
            'Password',
            style: GoogleFonts.inter(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          passwordTextField(size, passwordController),
          SizedBox(
            height: size.height * 0.03,
          ),

          //sign in button
          signInButton(context, size, isPressed, splashTimeout, callback,
              emailController.text, passwordController.text),
          SizedBox(
            height: size.height * 0.02,
          ),

          //we can connect text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: Divider()),
              const SizedBox(
                width: 16,
              ),
              Text(
                'We can Connect with',
                style: GoogleFonts.inter(
                  fontSize: 12.0,
                  color: const Color(0xFF969AA8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 16,
              ),
              const Expanded(child: Divider()),
            ],
          ),

          //footer section
          buildFooter(size),
        ],
      ),
    ),
  );
}

Widget logo(double height_, double width_) {
  return Image.asset(
    'lib/assets/logo/logo.png',
    height: height_,
    width: width_,
  );
}

Widget richText(double fontSize) {
  return Text.rich(
    TextSpan(
      style: GoogleFonts.inter(
        fontSize: fontSize,
        color: Colors.black, //const Color(0xFF21899C),
        letterSpacing: 2.0,
      ),
      children: const [
        TextSpan(
          text: 'SIGN-IN',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

Widget emailTextField(Size size, TextEditingController emailController) {
  return SizedBox(
    height: size.height / 13,
    child: TextField(
      controller: emailController,
      style: GoogleFonts.inter(
        fontSize: 18.0,
        color: const Color(0xFF151624),
      ),
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      cursorColor: const Color(0xFF151624),
      decoration: InputDecoration(
        hintText: 'Enter your email',
        hintStyle: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624).withOpacity(0.5),
        ),
        filled: true,
        fillColor: emailController.text.isEmpty
            ? const Color.fromRGBO(248, 247, 251, 1)
            : Colors.transparent,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: emailController.text.isEmpty
                  ? Colors.transparent
                  : const Color.fromRGBO(44, 185, 176, 1),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color.fromRGBO(44, 185, 176, 1),
            )),
        prefixIcon: Icon(
          Icons.mail_outline_rounded,
          color: emailController.text.isEmpty
              ? const Color(0xFF151624).withOpacity(0.5)
              : const Color.fromRGBO(44, 185, 176, 1),
          size: 16,
        ),
        suffix: Container(
          alignment: Alignment.center,
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: const Color.fromRGBO(44, 185, 176, 1),
          ),
          child: emailController.text.isEmpty
              ? const Center()
              : const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 13,
                ),
        ),
      ),
    ),
  );
}

Widget passwordTextField(Size size, TextEditingController passController) {
  return Container(
    height: size.height / 13,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color.fromRGBO(248, 247, 251, 1),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Icon(
            Icons.lock_outline_rounded,
            size: 16,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextField(
              controller: passController,
              style: GoogleFonts.inter(
                fontSize: 16.0,
                color: const Color(0xFF151624),
              ),
              cursorColor: const Color(0xFF151624),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: GoogleFonts.inter(
                  fontSize: 16.0,
                  color: const Color(0xFF151624).withOpacity(0.5),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          passController.text.isEmpty
              ? const Center()
              : Container(
                  height: 30,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(249, 225, 224, 1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: const Color.fromRGBO(254, 152, 121, 1),
                      )),
                  child: Text(
                    'View',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12.0,
                      color: const Color(0xFFFE9879),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ],
      ),
    ),
  );
}

Widget signInButton(BuildContext context, size, bool isPressed,
    Timer splashTimeout, var callback, String email, String password) {
  return GestureDetector(
      onTapDown: (details) {
        // Funzione chiamata quando si tiene premuto il widget
        callback(() {
          isPressed = true;
        });

        // Avvia il timer per mostrare l'effetto "splash" per un certo periodo di tempo
        splashTimeout = Timer(const Duration(milliseconds: 5000), () {
          callback(() {
            isPressed = false;
          });
        });
      },
      onTapUp: (details) async {
        // Funzione chiamata quando si smette di tenere premuto il widget
        callback(() {
          isPressed = false;
        });
        if (await checkCredentials(url, email, password)) {
          // setto le preferences all'utente loggato
          //TODO
          //setPreferences(id, user);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StatisticsScreen(),
            ),
          );
        }
      },
      onTapCancel: () {
        // Funzione chiamata se l'utente annulla la pressione (ad esempio, scorrendo il dito via dal widget)
        callback(() {
          isPressed = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C2E84).withOpacity(0.2),
              offset: const Offset(0, 15.0),
              blurRadius: 60.0,
            ),
          ],
        ),
        child: Text(
          'Sign in',
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ));
}

Widget buildFooter(Size size) {
  return Center(
    child: Column(
      children: <Widget>[
        //social logo: facebook, google & apple here
        SizedBox(
          height: size.height * 0.01,
        ),
        SizedBox(
          width: size.width * 0.6,
          height: 44.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //google logo here
              Container(
                alignment: Alignment.center,
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: const Color.fromRGBO(246, 246, 246, 1)),
                child: IconButton(
                  icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2008px-Google_%22G%22_Logo.svg.png'),
                  iconSize: 50,
                  onPressed: () => {}, //signInWithGoogle(context),
                ),
              ),
              const SizedBox(width: 16),
              //apple logo here
              Container(
                alignment: Alignment.center,
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: const Color.fromRGBO(246, 246, 246, 1)),
                child: IconButton(
                  icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png'),
                  iconSize: 23,
                  onPressed: () {},
                  //onPressed: () => //onFacebookLoginButtonPressed(context),
                ),
                /*SvgPicture.string(
                    // Vector
                    '<svg viewBox="13.0 11.0 18.62 22.92" ><path transform="translate(13.0, 11.0)" d="M 13.86734199523926 0.01146837882697582 C 13.81864452362061 -0.04295870289206505 12.0640869140625 0.03295278549194336 10.53726387023926 1.690114140510559 C 9.010440826416016 3.345843315124512 9.245336532592773 5.245062351226807 9.279711723327637 5.293760299682617 C 9.3140869140625 5.34245777130127 11.45679569244385 5.418369293212891 12.82463455200195 3.491936922073364 C 14.19247245788574 1.565504670143127 13.91604042053223 0.06732775270938873 13.86734199523926 0.01146837882697582 L 13.86734199523926 0.01146837882697582 Z M 18.61395645141602 16.8165454864502 C 18.54520606994629 16.67904663085938 15.28387928009033 15.04909896850586 15.5875244140625 11.91524410247803 C 15.89117050170898 8.77995777130127 17.98661231994629 7.920583248138428 18.01955604553223 7.827484607696533 C 18.05249786376953 7.73438549041748 17.16447639465332 6.695973873138428 16.22346115112305 6.170322895050049 C 15.53254699707031 5.799720764160156 14.76786804199219 5.587391376495361 13.98478984832764 5.548707962036133 C 13.83010196685791 5.544411182403564 13.29299354553223 5.41264009475708 12.18869590759277 5.714853763580322 C 11.46109199523926 5.913942337036133 9.821117401123047 6.558474063873291 9.369945526123047 6.584255218505859 C 8.917341232299805 6.610036373138428 7.570987701416016 5.83659839630127 6.122940540313721 5.631780624389648 C 5.196248054504395 5.452744007110596 4.213696002960205 5.819411754608154 3.510440826416016 6.10157299041748 C 2.808617830276489 6.382302284240723 1.473721981048584 7.181520938873291 0.5398677587509155 9.305609703063965 C -0.3939864635467529 11.42826557159424 0.09442496299743652 14.79128551483154 0.4439041316509247 15.83685874938965 C 0.7933833003044128 16.8809986114502 1.339086413383484 18.59258651733398 2.267211437225342 19.84154510498047 C 3.092211484909058 21.25092124938965 4.186482429504395 22.22917556762695 4.643383502960205 22.56146812438965 C 5.100284576416016 22.89375877380371 6.389346599578857 23.11433219909668 7.283096790313721 22.65743255615234 C 8.002107620239258 22.21628570556641 9.299763679504395 21.96277046203613 9.81252384185791 21.98138999938965 C 10.32385158538818 22.00000953674316 11.33218574523926 22.20196151733398 12.3648681640625 22.75339508056641 C 13.18270683288574 23.03555679321289 13.95614337921143 22.9181079864502 14.73101329803467 22.60300445556641 C 15.50588321685791 22.28646850585938 16.62736701965332 21.08620643615723 17.93648147583008 18.65274429321289 C 18.43348693847656 17.52123260498047 18.6597900390625 16.90964508056641 18.61395645141602 16.8165454864502 L 18.61395645141602 16.8165454864502 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    width: 18.62,
                    height: 22.92,
                  ),*/
              ),
            ],
          ),
        ),

        //footer text 'sign up' text here
        SizedBox(
          height: size.height * 0.01,
        ),
        Text.rich(
          TextSpan(
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: Colors.black,
            ),
            children: const [
              TextSpan(
                text: 'Don’t have an account? ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: 'Sign Up here',
                style: TextStyle(
                  color: Color(0xFFFF7248),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
