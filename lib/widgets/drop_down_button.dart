import 'package:flutter/material.dart';
import 'package:shop/screens/about_screen.dart';

class MyDropdownMenu extends StatefulWidget {
  const MyDropdownMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        focusColor: Colors.black,
        value: selectedValue,
        icon: Icon(Icons.menu),
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
            // print('Selected: $selectedValue');

            //----------------------Going to Selected options screen------
            if (newValue == 'option3') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              ).then((_) {//<-------when we pop out of selected option it wont add its name next to title
                setState(() {
                  selectedValue = null; 
                });
              });
            }
          });
        },
        items: <DropdownMenuItem<String>>[
          DropdownMenuItem<String>(
            value: 'option1',
            child: Text('Shopping Basket'),
          ),
          DropdownMenuItem<String>(
            value: 'option2',
            child: Text('Terms and Conditions'),
          ),
          DropdownMenuItem<String>(value: 'option3', child: Text('About')),
        ],
      ),
    );
  }
}
