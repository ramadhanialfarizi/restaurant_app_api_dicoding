import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/search');
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          //border: Border.all(),
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromARGB(255, 234, 234, 234),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: const [
              Expanded(child: Text('Search Restaurant...')),
              Icon(Icons.search),
            ],
          ),
        ),
      ),
    );
  }
}
