import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class PortfolioGallery extends StatefulWidget {
  final String title;
  final String archiveButtonText;
  final VoidCallback? onArchiveButtonTap;
  final List<GalleryImage>? images;
  final void Function(int index)? onImageTap;
  final bool pauseOnHover;
  final int marqueeRepeat;

  const PortfolioGallery({
    super.key,
    this.title = 'Browse my library',
    this.archiveButtonText = 'View gallery',
    this.onArchiveButtonTap,
    this.images,
    this.onImageTap,
    this.pauseOnHover = true,
    this.marqueeRepeat = 4,
  });

  @override
  State<PortfolioGallery> createState() => _PortfolioGalleryState();
}

class _PortfolioGalleryState extends State<PortfolioGallery> {
  int? _hoveredIndex;
  late final ScrollController _marqueeController;
  Timer? _marqueeTimer;
  bool _marqueePaused = false;

  static const _defaultImages = [
    GalleryImage(
      src:
          'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&h=600&fit=crop&q=80',
      alt: 'SaaS Dashboard',
    ),
    GalleryImage(
      src:
          'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&h=600&fit=crop&q=80',
      alt: 'Analytics',
    ),
    GalleryImage(
      src:
          'https://images.unsplash.com/photo-1553028826-f4804a6dba3b?w=800&h=600&fit=crop&q=80',
      alt: 'E-Commerce',
    ),
    GalleryImage(
      src:
          'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800&h=600&fit=crop&q=80',
      alt: 'Mobile App',
    ),
    GalleryImage(
      src:
          'https://images.unsplash.com/photo-1626785774573-4b799315345d?w=800&h=600&fit=crop&q=80',
      alt: 'Brand Identity',
    ),
    GalleryImage(
      src:
          'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=800&h=600&fit=crop&q=80',
      alt: 'Marketing',
    ),
    GalleryImage(
      src:
          'https://images.unsplash.com/photo-1559136555-9303baea8ebd?w=800&h=600&fit=crop&q=80',
      alt: 'Photography',
    ),
    GalleryImage(
      src:
          'https://images.unsplash.com/photo-1542744094-3a31f272c490?w=800&h=600&fit=crop&q=80',
      alt: 'Packaging',
    ),
    GalleryImage(
      src:
          'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?w=800&h=600&fit=crop&q=80',
      alt: 'Tech',
    ),
    GalleryImage(
      src:
          'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&h=600&fit=crop&q=80',
      alt: 'Workspace',
    ),
  ];

  List<GalleryImage> get _images => widget.images ?? _defaultImages;

  @override
  void initState() {
    super.initState();
    _marqueeController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startMarquee());
  }

  void _startMarquee() {
    _marqueeTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (_marqueePaused || !_marqueeController.hasClients) return;
      final max = _marqueeController.position.maxScrollExtent;
      final current = _marqueeController.offset;
      _marqueeController.jumpTo(current >= max ? 0 : current + 0.8);
    });
  }

  @override
  void dispose() {
    _marqueeTimer?.cancel();
    _marqueeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;
    return Container(
      color: Colors.black,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              if (isDesktop) _buildDesktopGallery() else _buildMobileMarquee(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 56, 32, 80),
      child: Column(
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 52,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 28),
          _ArchiveButton(
            text: widget.archiveButtonText,
            onTap: widget.onArchiveButtonTap,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopGallery() {
    final images = _images;
    final total = images.length;

    // ── Layout constants ───────────────────────────────────────────────────
    // Card visual size BEFORE the rotateY shrinks its apparent width.
    // rotateY(-45°) makes the rendered width ≈ cos(45°) × cardWidth ≈ 0.707 × cardWidth.
    const cardWidth = 300.0;
    const cardHeight = 188.0; // 16:9
    // How much each card is shifted right relative to the previous one.
    // With the tilt, the visible "step" is smaller, so we use a tight value
    // that matches the CSS -space-x-72 (≈ -288px) overlap.
    const xStep =
        72.0; // positive = shift right; cards overlay because cardWidth >> xStep
    const maxLift =
        120.0; // max upward shift for middle card (matches JS maxHeight=120)
    const galleryH = 340.0; // total height of the gallery area

    // Total span of card left-edges
    final totalSpan = xStep * (total - 1) + cardWidth;

    return SizedBox(
      height: galleryH,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Centre the whole fan
          final startX = (constraints.maxWidth - totalSpan) / 2;

          return Stack(
            clipBehavior: Clip.none,
            children: List.generate(total, (index) {
              // ── Stagger height: peak in middle, descend to edges ───────────
              // Exact port of the JS formula:
              //   middle = floor(total/2)
              //   distanceFromMiddle = abs(index - middle)
              //   staggerOffset = maxHeight - distance * 20
              final middle = total ~/ 2;
              final distFromMiddle = (index - middle).abs();
              final staggerOffset = (maxLift - distFromMiddle * 20).clamp(
                0.0,
                maxLift,
              );

              // ── Hover logic ────────────────────────────────────────────────
              final isHovered = _hoveredIndex == index;
              final isOtherHovered = _hoveredIndex != null && !isHovered;

              // yOffset: distance from top of gallery area to top of card.
              // Bigger staggerOffset → card sits higher (smaller top value).
              double topOffset;
              if (isHovered) {
                topOffset =
                    galleryH - cardHeight - staggerOffset - 80; // lift extra
              } else if (isOtherHovered) {
                topOffset = galleryH - cardHeight; // sink to baseline
              } else {
                topOffset = galleryH - cardHeight - staggerOffset;
              }

              return Positioned(
                // z-order: higher index = on top (right cards cover left cards, matching CSS z-index: totalImages - index reversed)
                // We achieve this by ordering the list: last Positioned wins in Flutter Stack.
                left: startX + index * xStep,
                top: topOffset,
                child: _TiltedCard(
                  key: ValueKey(index),
                  image: images[index],
                  width: cardWidth,
                  height: cardHeight,
                  isHovered: isHovered,
                  onHoverEnter: () => setState(() => _hoveredIndex = index),
                  onHoverExit: () => setState(() => _hoveredIndex = null),
                  onTap: () => widget.onImageTap?.call(index),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildMobileMarquee() {
    final repeated = List.generate(
      widget.marqueeRepeat,
      (_) => _images,
    ).expand((x) => x).toList();

    return GestureDetector(
      onTapDown: (_) {
        if (widget.pauseOnHover) setState(() => _marqueePaused = true);
      },
      onTapUp: (_) => setState(() => _marqueePaused = false),
      onTapCancel: () => setState(() => _marqueePaused = false),
      child: SizedBox(
        height: 160,
        child: ListView.separated(
          controller: _marqueeController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          itemCount: repeated.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (ctx, index) {
            final original = index % _images.length;
            return GestureDetector(
              onTap: () => widget.onImageTap?.call(original),
              child: _RoundedNetworkImage(
                src: repeated[index].src,
                width: 200,
                height: 125,
                radius: 8,
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Tilted Card (the key widget) ────────────────────────────────────────────
//
// Every card carries the SAME rotateY(-45°) perspective tilt at rest,
// exactly like the React version. On hover it smoothly un-tilts to ~0°.

class _TiltedCard extends StatefulWidget {
  final GalleryImage image;
  final double width;
  final double height;
  final bool isHovered;
  final VoidCallback onHoverEnter;
  final VoidCallback onHoverExit;
  final VoidCallback onTap;

  const _TiltedCard({
    super.key,
    required this.image,
    required this.width,
    required this.height,
    required this.isHovered,
    required this.onHoverEnter,
    required this.onHoverExit,
    required this.onTap,
  });

  @override
  State<_TiltedCard> createState() => _TiltedCardState();
}

class _TiltedCardState extends State<_TiltedCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  // Animate the rotateY angle: -45° at rest → 0° when hovered
  late Animation<double> _angleAnim;
  late Animation<double> _scaleAnim;

  static const _restAngle = -45.0;
  static const _hoverAngle = 0.0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _angleAnim = AlwaysStoppedAnimation(_restAngle);
    _scaleAnim = AlwaysStoppedAnimation(1.0);
  }

  @override
  void didUpdateWidget(_TiltedCard old) {
    super.didUpdateWidget(old);
    if (widget.isHovered == old.isHovered) return;

    if (widget.isHovered) {
      _angleAnim = Tween<double>(
        begin: _restAngle,
        end: _hoverAngle,
      ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
      _scaleAnim = Tween<double>(
        begin: 1.0,
        end: 1.06,
      ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    } else {
      _angleAnim = Tween<double>(
        begin: _hoverAngle,
        end: _restAngle,
      ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeIn));
      _scaleAnim = Tween<double>(
        begin: 1.06,
        end: 1.0,
      ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeIn));
    }
    _ctrl.forward(from: 0);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  /// Mimics CSS: perspective(5000px) rotateY(angleDeg)
  Matrix4 _perspectiveRotateY(double angleDeg) {
    final rad = angleDeg * math.pi / 180.0;
    return Matrix4.identity()
      ..setEntry(3, 2, 1 / 5000) // perspective
      ..rotateY(rad);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => widget.onHoverEnter(),
      onExit: (_) => widget.onHoverExit(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, child) => Transform(
            alignment: Alignment.center,
            transform: _perspectiveRotateY(_angleAnim.value)
              ..scale(_scaleAnim.value, _scaleAnim.value),
            child: child,
          ),
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                // Right-side depth shadow (matches JS: offset 20px right)
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(20, 0),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(6, 0),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 2,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: _RoundedNetworkImage(
              src: widget.image.src,
              width: widget.width,
              height: widget.height,
              radius: 0, // already clipped by parent
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Reusable network image ───────────────────────────────────────────────────

class _RoundedNetworkImage extends StatelessWidget {
  final String src;
  final double width;
  final double height;
  final double radius;

  const _RoundedNetworkImage({
    required this.src,
    required this.width,
    required this.height,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        src,
        width: width,
        height: height,
        fit: BoxFit.cover,
        alignment: Alignment.topLeft,
        loadingBuilder: (_, child, prog) => prog == null
            ? child
            : Container(
                width: width,
                height: height,
                color: Colors.white10,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white30,
                    strokeWidth: 2,
                  ),
                ),
              ),
        errorBuilder: (_, __, ___) => Container(
          width: width,
          height: height,
          color: Colors.white10,
          child: const Icon(Icons.broken_image, color: Colors.white24),
        ),
      ),
    );
  }
}

// ─── Archive Button ───────────────────────────────────────────────────────────

class _ArchiveButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  const _ArchiveButton({required this.text, this.onTap});

  @override
  State<_ArchiveButton> createState() => _ArchiveButtonState();
}

class _ArchiveButtonState extends State<_ArchiveButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? Colors.white.withOpacity(0.85) : Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 10),
              AnimatedSlide(
                offset: _hovered ? const Offset(0.2, 0) : Offset.zero,
                duration: const Duration(milliseconds: 150),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Data Model ───────────────────────────────────────────────────────────────

class GalleryImage {
  final String src;
  final String alt;
  final String? title;
  const GalleryImage({required this.src, required this.alt, this.title});
}
