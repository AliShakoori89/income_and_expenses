import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes{
   static final darkTheme = ThemeData(
     textTheme: TextTheme(
       titleLarge: GoogleFonts.ubuntu(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
       bodySmall: GoogleFonts.ubuntu(color: Colors.white, fontSize: 15),
       labelSmall: GoogleFonts.ubuntu(color: Colors.white54, fontSize: 13),
       titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
     ),
     unselectedWidgetColor: Colors.white70,
     primaryColor: Colors.black,
     scaffoldBackgroundColor: Colors.grey.shade900,
     primaryColorDark: Colors.blueAccent[700],
     secondaryHeaderColor: Colors.white,
     iconTheme: const IconThemeData(color: Color.fromRGBO(117, 117, 117, 1.00), opacity: 0.8),
   );

   static final lightTheme = ThemeData(
       textTheme: TextTheme(
         titleLarge: GoogleFonts.ubuntu(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
         bodySmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 15),
         labelSmall: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 13),
         titleSmall: GoogleFonts.ubuntu(color: Colors.black, fontSize: 12),
       ),
       unselectedWidgetColor: Colors.black,
       primaryColor: Colors.white,
       scaffoldBackgroundColor: Colors.white,
       primaryColorDark: Colors.blueAccent,
       secondaryHeaderColor: Colors.black,
       iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8)
   );
}