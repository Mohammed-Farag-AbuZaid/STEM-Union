import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
   const NavBar({super.key});

   @override
   Widget build(BuildContext context) {
     return Container(
       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(
             'Logo',
             style: Theme.of(context).textTheme.headlineSmall,
           ),
           Row(
             children: [
               TextButton(
                 onPressed: () {},
                 child: const Text('Home'),
               ),
               TextButton(
                 onPressed: () {},
                 child: const Text('About'),
               ),
               TextButton(
                 onPressed: () {},
                 child: const Text('Contact'),
               ),
             ],
           ),
         ],
       ),
     );
   }
 }