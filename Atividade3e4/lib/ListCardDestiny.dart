import 'package:flutter/material.dart';

class listCardDestiny extends StatelessWidget {
  final String nome;
  final double km;
  final Function() onRemoved;

  const listCardDestiny({
    required this.nome,
    required this.km,
    required this.onRemoved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        onRemoved();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFE4E1), Color(0xFFFFC1C1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.pin_drop_outlined,
              color: Colors.pinkAccent,
              size: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "$km KM",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.pinkAccent,
              ),
              onPressed: onRemoved,
            ),
          ],
        ),
      ),
    );
  }
}
