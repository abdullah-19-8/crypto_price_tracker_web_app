import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitialView extends StatefulWidget {
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search for your favourite coin!',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
            SizedBox(height: 50),
            TextField(
              controller: _searchController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Search for coin",
                contentPadding: const EdgeInsets.all(20),
                labelStyle: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2D2C2A),
                ),
                filled: true,
                fillColor: const Color(0xFFF2F2F2),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFF2F2F2),
                  ),
                ),
              ),
              onSubmitted: (value) {
                final coin = _searchController.text;
                if (coin.isNotEmpty) {
                  GoRouter.of(context).go('/crypto/$coin');
                }
              },
            ),
            SizedBox(height: 25),
            ElevatedButton(
                onPressed: () {
                  final coin = _searchController.text;
                  if (coin.isNotEmpty) {
                    GoRouter.of(context).go('/crypto/$coin');
                  }
                },
                child: Text("Search"))
          ],
        ),
      ),
    );
  }
}
