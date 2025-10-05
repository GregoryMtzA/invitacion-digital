import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:invitacion_web/core/consts.dart';
import 'package:invitacion_web/core/utils.dart';
import 'package:invitacion_web/widgets/carousel.dart';
import 'package:invitacion_web/widgets/countdown_widget.dart';
import 'package:invitacion_web/widgets/music_controls.dart';
import 'package:invitacion_web/widgets/responsive_layout.dart';
import '../widgets/responsive_container.dart';

class InvStyles {

  static TextStyle title = GoogleFonts.dancingScript(fontSize: 40, color: AppColors.onSurfaceGold, fontWeight: FontWeight.bold);
  static TextStyle subtitle = GoogleFonts.allura(fontSize: 35, color: AppColors.onSurfaceLight,);
  static TextStyle text = GoogleFonts.playfairDisplay(fontSize: 18, color: AppColors.onSurfaceLight);

}

class Invitation1 extends StatefulWidget {

  String name;
  DateTime fecha;
  String portada;
  String portadaMovil;

  Invitation1({
    super.key,
    required this.portada,
    required this.portadaMovil,
    required this.name,
    required this.fecha,
  });

  @override
  State<Invitation1> createState() => _Invitation1State();
}

class _Invitation1State extends State<Invitation1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      body: ResponsiveLayout(
        builder: (context, type) {
          switch (type) {
            case DeviceType.mobile:
              return _mobile(context);
            case DeviceType.tablet:
              return _mobile(context);
            case DeviceType.laptop:
              return _laptop(context);
            case DeviceType.desktop:
              return _desktop(context);
          }
        },
      ),
    );
  }

  Widget _desktop(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          //! Header
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(widget.portada, height: size.height, width: double.infinity, fit: BoxFit.cover,),
              Positioned(
                left: size.width * 0.10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //* Nombre
                    Text(
                      widget.name,
                      style: GoogleFonts.dancingScript(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 50,),
                    Row(
                      spacing: 20,
                      children: [
                        Container(
                          width: 150,
                          height: 2,
                          color: Colors.white,
                        ),
                        Text(
                          "MIS XV",
                          style: GoogleFonts.playfairDisplay(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 2,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      DateFormat("dd 'de' MMMM 'del' yyyy", "es_ES").format(widget.fecha),
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //! Contador Regresivo
        ],
      ),
    );
  }

  Widget _laptop(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          //! Header
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(widget.portada, height: size.height, width: double.infinity, fit: BoxFit.cover,),
              Positioned(
                left: size.width * 0.05,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //* Nombre
                    Text(
                      widget.name,
                      style: InvStyles.title,
                    ),
                    const SizedBox(height: 50,),
                    Row(
                      spacing: 20,
                      children: [
                        Container(
                          width: 150,
                          height: 2,
                          color: Colors.white,
                        ),
                        Text(
                          "MIS XV",
                          style: GoogleFonts.playfairDisplay(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 2,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      DateFormat("dd 'de' MMMM 'del' yyyy", "es_ES").format(widget.fecha),
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tablet(BuildContext context) {
    return Container(color: Colors.blue,);
  }

  Widget _mobile(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //! Header
          Stack(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), // color del overlay
                  BlendMode.srcATop,             // mezcla el color sobre la imagen
                ),
                child: Image.asset(widget.portadaMovil, height: size.height, width: double.infinity, fit: BoxFit.cover,)
              ),
              Positioned(
                bottom: size.height * 0.08,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //* Nombre
                    Container(
                      width: 320,
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      child: Text(
                        widget.name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: InvStyles.title,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        Container(
                          width: 80,
                          height: 2,
                          color: Colors.white,
                        ),
                        Text(
                          "MIS XV",
                          style: GoogleFonts.playfairDisplay(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 2,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      DateFormat("dd 'de' MMMM 'del' yyyy", "es_ES").format(widget.fecha),
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //! Musica y Texto
          Stack(
            alignment: Alignment.center,
            children: [
              // Musica y texto
              Column(
                children: [
                  const SizedBox(height: 40,),
                  MobileContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              Text(
                                "Dale play a mi canción favorita",
                                textAlign: TextAlign.center,
                                style: InvStyles.title,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: BoxBorder.all(color: AppColors.accent, width: 2)
                                ),
                                child: MusicControls(music: "song.mp3"),
                              )
                            ],
                          ),
                        ),
                      )
                  ),
                  const SizedBox(height: 20,),
                  MobileContainer(
                      child: Center(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 20,
                                children: [
                                  Text(
                                    "Hay eventos en la vida que son muy especiales por si solos, pero poder compartirlos con quienes más quiero, los convierte en momentos únicos e inolvidables.",
                                    maxLines: 6,
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.playfairDisplay(fontSize: 18),
                                  ),
                                  Text(
                                    maxLines: 1,
                                    "¡Te esperamos en mi fiesta!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.playfairDisplay(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: RotatedBox(
                                quarterTurns: 2,
                                child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  const SizedBox(height: 40,),
                ],
              ),
              // Flores
              Positioned(
                top: -35,
                left: -25,
                child: Image.asset(AppAssets.rosas1, height: 150,),
              ),
              Positioned(
                top: -35,
                right: -25,
                child: RotatedBox(
                    quarterTurns: 1,
                    child: Image.asset(AppAssets.rosas1, height: 150,)
                ),
              ),
            ],
          ),
          //! Contador Regresivo
          Stack(
            alignment: Alignment.center,
            children: [
              //* Imagen
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), // color del overlay
                  BlendMode.srcATop,             // mezcla el color sobre la imagen
                ),
                child: Image.asset(
                  AppAssets.portrait2,
                  fit: BoxFit.cover,
                ),
              ),
              MobileContainer(
                border: false,
                child: Center(
                  child: Column(
                    spacing: 40,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tan solo faltán",
                        style: InvStyles.title,
                      ),
                      Countdown(
                        target: widget.fecha,
                        style: GoogleFonts.playfairDisplay(fontSize: 32, color: Colors.white),
                      ),
                      Text(
                        "Para este día tan especial",
                        style: GoogleFonts.dancingScript(fontSize: 32, color: Colors.white),
                      ),
                    ],
                  ),
                )
              )
            ],
          ),
          //! Itinerario
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 40,),
                  MobileContainer(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "¿Cuando y donde?",
                                style: InvStyles.title,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                "A continuación encontrarás el horario y ubicación de los eventos de mi fiesta, asi como un botón directo a Google Maps para que te sea más facil llegar al lugar.",
                                style: InvStyles.text,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20,),
                              Text(
                                "Itinerario",
                                style: InvStyles.title,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10,),
                              // Itinerario 1
                              Column(
                                spacing: 5,
                                children: [
                                  Icon(Icons.church_outlined, color: AppColors.primary, size: 48,),
                                  Text(
                                    "5:00 PM",
                                    style: InvStyles.text,
                                  ),
                                  InkWell(
                                    onTap: () => launchInNewTab("https://www.google.com/maps?q=Parroquia+Cristo+Rey,+Veracruz+20,+Pedro+Jos%C3%A9+M%C3%A9ndez,+87040+Cdad.+Victoria,+Tamps.&ftid=0x86795309533407fb:0x68d69285cb4ed8aa&entry=gps&lucs=,94284505,94224825,94227247,94227248,94231188,94280568,47071704,47069508,94218641,94282134,94203019,47084304&g_ep=CAISEjI1LjM5LjIuODEwMTI3MDQ4MBgAIIgnKmwsOTQyODQ1MDUsOTQyMjQ4MjUsOTQyMjcyNDcsOTQyMjcyNDgsOTQyMzExODgsOTQyODA1NjgsNDcwNzE3MDQsNDcwNjk1MDgsOTQyMTg2NDEsOTQyODIxMzQsOTQyMDMwMTksNDcwODQzMDRCAk1Y&skid=1f6f49dc-25fd-4f51-8280-7a693fdb88bc&g_st=iw"),
                                    borderRadius: BorderRadius.circular(8),
                                    child: MobileContainer(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Ver ubicación",
                                          style: InvStyles.text.copyWith(color: AppColors.secondary),
                                        )
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20,),
                              // Itinerario 2
                              Column(
                                spacing: 5,
                                children: [
                                  Icon(Icons.schedule, color: AppColors.primary, size: 48,),
                                  Text(
                                    "6:30 PM",
                                    style: InvStyles.text,
                                  ),
                                  InkWell(
                                    onTap: () => launchInNewTab("https://www.google.com/maps?q=Stoa+Sal%C3%B3n+de+Eventos+Sociales,+Laurel+226,+Col+del+Maestro,+87070+Cdad.+Victoria,+Tamps.&ftid=0x85d7f9e718fe6f49:0x6c81f2a2d66c795&entry=gps&lucs=,94284505,94224825,94227247,94227248,94231188,94280568,47071704,47069508,94218641,94282134,94203019,47084304&g_ep=CAISEjI1LjM5LjIuODEwMTI3MDQ4MBgAIIgnKmwsOTQyODQ1MDUsOTQyMjQ4MjUsOTQyMjcyNDcsOTQyMjcyNDgsOTQyMzExODgsOTQyODA1NjgsNDcwNzE3MDQsNDcwNjk1MDgsOTQyMTg2NDEsOTQyODIxMzQsOTQyMDMwMTksNDcwODQzMDRCAk1Y&skid=975c594c-fa53-4f7b-91da-d852a6b6e480&g_st=iw"),
                                    borderRadius: BorderRadius.circular(8),
                                    child: MobileContainer(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Ver ubicación",
                                          style: InvStyles.text.copyWith(color: AppColors.secondary),
                                        )
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                          ),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
              Positioned(
                top: -35,
                left: -25,
                child: Image.asset(AppAssets.rosas1, height: 150,),
              ),
              Positioned(
                top: -35,
                right: -25,
                child: RotatedBox(
                    quarterTurns: 1,
                    child: Image.asset(AppAssets.rosas1, height: 150,)
                ),
              ),
            ],
          ),
          //! Código de Vestimenta
          Column(
            children: [
              const SizedBox(height: 20,),
              MobileContainer(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              "Código de Vestimenta",
                              style: InvStyles.title,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              "Formal",
                              style: InvStyles.text,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20,),
                            Image.asset(AppAssets.dressCode, height: 120,),
                            const SizedBox(height: 10,),
                            Text(
                              "Prohibido el color rosa",
                              style: InvStyles.text.copyWith(color: AppColors.primary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: Image.asset(AppAssets.vintageCornerBorder, height: 80,),
                        ),
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 40,),
            ],
          ),
          //! Confirmacion de asistencia
          SizedBox(
            height: size.height * 0.8,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.srcATop,
                    ),
                    child: Image.asset(
                      AppAssets.portrait1,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Contenido centrado respetando maxWidth interno
                MobileContainer(
                  border: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Confirma tu asistencia", style: InvStyles.title, textAlign: TextAlign.center),
                        Column(
                          children: [
                            Text("¡Quiero compartir este momento tan esperado contigo!",
                                style: InvStyles.text.copyWith(color: Colors.white),
                                textAlign: TextAlign.center),
                            Text("Por favor ayúdanos confirmando tu asistencia.",
                                style: InvStyles.text.copyWith(color: Colors.white),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: openWhatsAppConfirmation,
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: Colors.white)),
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                            foregroundColor: AppColors.primary
                          ),
                          child: Text("Confirmar")
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //! Galeria
          Column(
            children: [
              const SizedBox(height: 40,),
              Text("Galería", style: InvStyles.title,),
              Text("¡Mi sesión de fotos!", style: InvStyles.subtitle,),
              const SizedBox(height: 20,),
              InfiniteAssetCarousel(
                assets: [
                  AppAssets.landscape1,
                  AppAssets.landscape2,
                  AppAssets.portrait1,
                  AppAssets.landscape3,
                  AppAssets.portrait2
                ],
                height: 320,
                autoPlay: true,
                indicatorActiveColor: AppColors.primary,
                viewportFraction: 0.75,  // se ve parte del siguiente
                radius: 20,
                fit: BoxFit.cover,        // maneja vertical/horizontal
                enableTransform: true,    // activa efecto
                parallax: 20,
                showIndicators: true,
              )
            ],
          ),
          //! Final
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 320,
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    Text(
                      "¡Los mejores momentos de la vida merecen ser compartidos!",
                      style: InvStyles.text,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20,),
                    Text("Gracias por acompañarme", style: InvStyles.subtitle.copyWith(fontSize: 25),),
                    const SizedBox(height: 50,),
                  ],
                ),
              ),
              Positioned(
                bottom: -35,
                left: -25,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Image.asset(AppAssets.rosas1, height: 150,)
                ),
              ),
              Positioned(
                bottom: -35,
                right: -25,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Image.asset(AppAssets.rosas1, height: 150,)
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}