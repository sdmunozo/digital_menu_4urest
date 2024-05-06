import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 52,
        child: Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color(0xffe3e3e6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
          ],
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        hintText: "Buscar Platillos o Bebidas",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 15,
                    color: Colors.black26,
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.magnifyingGlass,
                        color: Color(0xff88888a)),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ]);
  }
}


/*import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 52,
        child: Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color(0xffe3e3e6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
          ],
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        hintText: "Buscar Platillos o Bebidas",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 15,
                    color: Colors.black26,
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.magnifyingGlass,
                        color: Color(0xff88888a)),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ]);
  }
}
*/