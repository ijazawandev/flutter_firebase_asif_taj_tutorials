import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const RoundButton({super.key,

    required this.title,
    required this.onTap,
    this.loading = false
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 40,
        child: Center(child: loading ? CircularProgressIndicator(
            strokeWidth: 3, color: Colors.white, ) : Text(
          title, style: TextStyle(color: Colors.white),)),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
