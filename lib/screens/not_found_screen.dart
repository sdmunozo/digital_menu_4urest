import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/providers/image_provider.dart';
import 'package:digital_menu_4urest/widgets/circular_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String urlInstagram = 'https://www.instagram.com/4urest/';
    String urlWhatsApp =
        'https://api.whatsapp.com/send?phone=5218180836587&text=%C2%A1Hola%204uRest!%20estoy%20interesado%20en%3A';
    String urlWeb = 'https://landing.4urest.mx/';

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: BuildNotFoundScreen(
            urlWhatsApp: urlWhatsApp,
            urlInstagram: urlInstagram,
            urlWeb: urlWeb),
      ),
    );
  }
}

class BuildNotFoundScreen extends StatelessWidget {
  const BuildNotFoundScreen({
    super.key,
    required this.urlWhatsApp,
    required this.urlInstagram,
    required this.urlWeb,
  });

  final String urlWhatsApp;
  final String urlInstagram;
  final String urlWeb;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Column(
      children: [
        BuildNotFoundContent(
            urlWhatsApp: urlWhatsApp,
            urlInstagram: urlInstagram,
            urlWeb: urlWeb)
      ],
    ));

    //
  }
}

class BuildNotFoundContent extends StatelessWidget {
  const BuildNotFoundContent({
    super.key,
    required this.urlWhatsApp,
    required this.urlInstagram,
    required this.urlWeb,
  });

  final String urlWhatsApp;
  final String urlInstagram;
  final String urlWeb;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageProvider.getImage(
                    CustomImageProvider.png4uRestOriginal,
                    width: 200),
                const SizedBox(height: 40),
                const Text(
                  'Menú no encontrado',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Lo sentimos, el menú que buscas no existe. Visita nuestras redes sociales.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularButtonWidget(
                      iconData: FontAwesomeIcons.whatsapp,
                      url: urlWhatsApp,
                    ),
                    const SizedBox(width: 20),
                    CircularButtonWidget(
                      iconData: FontAwesomeIcons.instagram,
                      url: urlInstagram,
                    ),
                    const SizedBox(width: 20),
                    CircularButtonWidget(
                      iconData: FontAwesomeIcons.paperclip,
                      url: urlWeb,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
