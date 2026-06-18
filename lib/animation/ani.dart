import 'package:flutter/material.dart';

class BentoItemData {
  final String title;
  final String description;

  const BentoItemData({required this.title, required this.description});
}

class SimpleBentoGrid extends StatelessWidget {
  final List<BentoItemData> items;
  final double spacing;

  const SimpleBentoGrid({super.key, required this.items, this.spacing = 20.0});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text("No items available in the list."));
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return _buildDynamicDesktopLayout();
          } else if (constraints.maxWidth > 600) {
            return _buildDynamicTabletLayout();
          } else {
            return _buildDynamicMobileLayout();
          }
        },
      ),
    );
  }

  // ==========================================
  // DYNAMIC DESKTOP LAYOUT (Repeats every 5 items)
  // ==========================================
  Widget _buildDynamicDesktopLayout() {
    List<Widget> gridRows = [];

    // Loops through the list in steps of 5
    for (int i = 0; i < items.length; i += 5) {
      int remaining = items.length - i;

      // 1. First Row of the pattern Block: 2:1 Asymmetric Split
      if (remaining >= 2) {
        gridRows.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: SimpleBentoCard(
                  title: items[i].title,
                  description: items[i].description,
                  forcedHeight: 260,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                flex: 1,
                child: SimpleBentoCard(
                  title: items[i + 1].title,
                  description: items[i + 1].description,
                  forcedHeight: 260,
                ),
              ),
            ],
          ),
        );
        gridRows.add(SizedBox(height: spacing));
      } else if (remaining == 1) {
        // If only 1 item left, fill full width
        gridRows.add(
          SimpleBentoCard(
            title: items[i].title,
            description: items[i].description,
            forcedHeight: 260,
          ),
        );
        gridRows.add(SizedBox(height: spacing));
        break;
      }

      // 2. Second Row of the pattern Block: Full-Width Belt
      if (remaining >= 3) {
        gridRows.add(
          SimpleBentoCard(
            title: items[i + 2].title,
            description: items[i + 2].description,
            forcedHeight: 160,
          ),
        );
        gridRows.add(SizedBox(height: spacing));
      }

      // 3. Third Row of the pattern Block: 1:1 Equal Split
      if (remaining == 4) {
        // If only 1 item left in this block sequence
        gridRows.add(
          SimpleBentoCard(
            title: items[i + 3].title,
            description: items[i + 3].description,
            forcedHeight: 220,
          ),
        );
        gridRows.add(SizedBox(height: spacing));
      } else if (remaining >= 5) {
        gridRows.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SimpleBentoCard(
                  title: items[i + 3].title,
                  description: items[i + 3].description,
                  forcedHeight: 220,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: SimpleBentoCard(
                  title: items[i + 4].title,
                  description: items[i + 4].description,
                  forcedHeight: 220,
                ),
              ),
            ],
          ),
        );
        gridRows.add(SizedBox(height: spacing));
      }
    }

    // Wrap in a Column inside a scrollview container to keep layout clean
    return Column(children: gridRows);
  }

  // ==========================================
  // DYNAMIC TABLET LAYOUT (Balanced 2-Column Repeat)
  // ==========================================
  Widget _buildDynamicTabletLayout() {
    List<Widget> gridRows = [];

    // Form pairs of 2 items each dynamically
    for (int i = 0; i < items.length; i += 2) {
      int remaining = items.length - i;

      if (remaining >= 2) {
        gridRows.add(
          Row(
            children: [
              Expanded(
                child: SimpleBentoCard(
                  title: items[i].title,
                  description: items[i].description,
                  forcedHeight: 220,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: SimpleBentoCard(
                  title: items[i + 1].title,
                  description: items[i + 1].description,
                  forcedHeight: 220,
                ),
              ),
            ],
          ),
        );
        gridRows.add(SizedBox(height: spacing));
      } else {
        // Trailing odd single element fills full width elegantly
        gridRows.add(
          SimpleBentoCard(
            title: items[i].title,
            description: items[i].description,
            forcedHeight: 220,
          ),
        );
        gridRows.add(SizedBox(height: spacing));
      }
    }

    return Column(children: gridRows);
  }

  // ==========================================
  // DYNAMIC MOBILE LAYOUT (Infinite Clean List)
  // ==========================================
  Widget _buildDynamicMobileLayout() {
    // Standard map converts any list length straight down into vertical cells
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) {
        return SimpleBentoCard(
          title: items[index].title,
          description: items[index].description,
        );
      },
    );
  }
}

class SimpleBentoCard extends StatelessWidget {
  final String title;
  final String description;
  final double? forcedHeight;

  const SimpleBentoCard({
    super.key,
    required this.title,
    required this.description,
    this.forcedHeight,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: forcedHeight,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF09090B) : Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isDark ? const Color(0xFF27272A) : const Color(0xFFE4E4E7),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              forcedHeight != null
                  ? Expanded(
                      child: Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: forcedHeight! > 200 ? 6 : 3,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: isDark
                              ? const Color(0xFFA1A1AA)
                              : const Color(0xFF71717A),
                        ),
                      ),
                    )
                  : Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: isDark
                            ? const Color(0xFFA1A1AA)
                            : const Color(0xFF71717A),
                      ),
                    ),
            ],
          ),
        ),
        // const Positioned(top: -5, left: -5, child: SimplePlusMark()),
        // const Positioned(top: -5, right: -5, child: SimplePlusMark()),
        // const Positioned(bottom: -5, left: -5, child: SimplePlusMark()),
        // const Positioned(bottom: -5, right: -5, child: SimplePlusMark()),
      ],
    );
  }
}

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
