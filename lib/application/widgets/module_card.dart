// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:edulearn/models/module.dart';
import 'package:google_fonts/google_fonts.dart';

class ModuleCard extends StatelessWidget {
  final Module module;

  const ModuleCard({
    super.key,
    required this.module,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.1))
        
      ),
      child: Row(
        children: [
          const SizedBox(width: 10,),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              module.moduleUrl,
              width: 65,
              height: 76,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module.title,
                          style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: Image.asset('assets/icons/duration.png', width: 16,), 
                            ),
                            Text(
                          '${module.duration} min',
                          style: GoogleFonts.roboto(fontSize: 14, color: const Color.fromRGBO(230, 126, 34, 1), fontWeight: FontWeight.bold),
                        ),// Adjusted size
                          ],
                        )
                        
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(onPressed: ()=>print("play"), 
                  icon: const Icon(Icons.play_circle_outline,
                  size: 30,
                  color: Color.fromRGBO(230, 126, 34, 1),))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
