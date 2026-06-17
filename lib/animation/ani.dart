import 'package:flutter/material.dart';

// Your data model
class BentoItemData {
  final String title;
  final String description;

  const BentoItemData({required this.title, required this.description});
}

class SimpleBentoGrid extends StatelessWidget {
  final List<BentoItemData> items;
  final double spacing;

  const SimpleBentoGrid({
    super.key,
    required this.items,
    this.spacing = 20.0, // Controls the gap between separated boxes
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Simple column count switch based on screen width
    int crossAxisCount = 1; // Mobile
    if (screenWidth > 900) {
      crossAxisCount = 3; // Desktop
    } else if (screenWidth > 600) {
      crossAxisCount = 2; // Tablet
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          mainAxisExtent:
              220, // Forces every box to have an identical clean height
        ),
        itemBuilder: (context, index) {
          return SimpleBentoCard(
            title: items[index].title,
            description: items[index].description,
          );
        },
      ),
    );
  }
}

class SimpleBentoCard extends StatelessWidget {
  final String title;
  final String description;

  const SimpleBentoCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      clipBehavior:
          Clip.none, // Allows the corner '+' icons to pop out slightly
      children: [
        // The Box Body
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF09090B) : Colors.white,
            borderRadius: BorderRadius.circular(4), // Slightly soft corners
            border: Border.all(
              color: isDark ? const Color(0xFF27272A) : const Color(0xFFE4E4E7),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines:
                      5, // Keeps text neatly capped inside the height boundaries
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: isDark
                        ? const Color(0xFFA1A1AA)
                        : const Color(0xFF71717A),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Clean, standalone corner crosshairs positioned perfectly
        const Positioned(top: -5, left: -5, child: SimplePlusMark()),
        const Positioned(top: -5, right: -5, child: SimplePlusMark()),
        const Positioned(bottom: -5, left: -5, child: SimplePlusMark()),
        const Positioned(bottom: -5, right: -5, child: SimplePlusMark()),
      ],
    );
  }
}

// Minimalistic plus icon layout
class SimplePlusMark extends StatelessWidget {
  const SimplePlusMark({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? const Color(0xFF52525B) : const Color(0xFFA1A1AA);

    return Text(
      '+',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: color,
        height: 1.0,
      ),
    );
  }
}
