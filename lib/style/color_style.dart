import 'package:flutter/material.dart';

class ColorStyle {
  static const Color white = Color(0xFFEFE6DD);
  static const Color red = Colors.red;
  static const Color black = Color(0xFF181312);

  static final gradientColorSkill = [
    // 1. Red → Orange → Yellow
    [Color(0xFFFF005C), Color(0xFFFF4D4D), Color(0xFFFFBC00)],

    // 2. Pink → Purple → Blue
    [Color(0xFFFF1493), Color(0xFFB84DFF), Color(0xFF1DA1FF)],

    // 3. Cyan → Teal → Green
    [Color(0xFF00D4FF), Color(0xFF00E5C3), Color(0xFF7CFF2B)],

    // 4. Purple → Indigo → Cyan
    [Color(0xFF8A2BE2), Color(0xFF5B5FFF), Color(0xFF00E5FF)],

    // 5. Orange → Pink → Purple
    [Color(0xFFFF7A00), Color(0xFFFF4D8D), Color(0xFFB84DFF)],

    // 6. Green → Aqua → Blue
    [Color(0xFF39FF14), Color(0xFF00FFA3), Color(0xFF00D4FF)],

    // 7. Gold → Orange → Red
    [Color(0xFFFFD700), Color(0xFFFF8C00), Color(0xFFFF3D3D)],

    // 8. Sky Blue → Royal Blue → Purple
    [Color(0xFF00C6FF), Color(0xFF0072FF), Color(0xFF8E2DE2)],

    // 9. Mint → Emerald → Lime
    [Color(0xFF00FFB3), Color(0xFF00C853), Color(0xFFAEEA00)],

    // 10. Magenta → Violet → Electric Blue
    [Color(0xFFFF00FF), Color(0xFF7F00FF), Color(0xFF00BFFF)],
  ];

  static final gradientColorproduct = [
    [
      Color(0xFFADA996),
      Color(0xFFF2F2F2),
      Color(0xFFDBDBDB),
      Color(0xFFEAEAEA),

      Color(0xFFEAEAEA),
      Color(0xFFDBDBDB),
      Color(0xFFF2F2F2),
      Color(0xFFADA996),
    ],

    [
      Color(0xFF03001E),
      Color(0xFF7303C0),
      Color(0xFFEC38BC),
      Color(0xFFFDEFF9),

      Color(0xFFFDEFF9),
      Color(0xFFEC38BC),
      Color(0xFF7303C0),
      Color(0xFF03001E),
    ],

    [
      Color(0xFFFF1E56),
      Color(0xFFF9C942),
      Color(0xFF1E90FF),
      Color(0xFFEAF6FF),

      Color(0xFFEAF6FF),
      Color(0xFF1E90FF),
      Color(0xFFF9C942),
      Color(0xFFFF1E56),
    ],

    [
      Color(0xFF0F2027),
      Color(0xFF203A43),
      Color(0xFF2C5364),
      Color(0xFFE0F7FA),

      Color(0xFFE0F7FA),
      Color(0xFF2C5364),
      Color(0xFF203A43),
      Color(0xFF0F2027),
    ],

    [
      Color(0xFF654EA3),
      Color(0xFFEAAFc8),
      Color(0xFFF7D9E3),
      Color(0xFFFFF5F8),

      Color(0xFFFFF5F8),
      Color(0xFFF7D9E3),
      Color(0xFFEAAFc8),
      Color(0xFF654EA3),
    ],

    [
      Color(0xFF11998E),
      Color(0xFF38EF7D),
      Color(0xFFB7FFD0),
      Color(0xFFF3FFF8),

      Color(0xFFF3FFF8),
      Color(0xFFB7FFD0),
      Color(0xFF38EF7D),
      Color(0xFF11998E),
    ],

    [
      Color(0xFFFF512F),
      Color(0xFFF09819),
      Color(0xFFFFD194),
      Color(0xFFFFF5E8),

      Color(0xFFFFF5E8),
      Color(0xFFFFD194),
      Color(0xFFF09819),
      Color(0xFFFF512F),
    ],

    [
      Color(0xFF4E54C8),
      Color(0xFF8F94FB),
      Color(0xFFC5C8FF),
      Color(0xFFF2F3FF),

      Color(0xFFF2F3FF),
      Color(0xFFC5C8FF),
      Color(0xFF8F94FB),
      Color(0xFF4E54C8),
    ],

    [
      Color(0xFF355C7D),
      Color(0xFF6C5B7B),
      Color(0xFFC06C84),
      Color(0xFFFFE6EC),

      Color(0xFFFFE6EC),
      Color(0xFFC06C84),
      Color(0xFF6C5B7B),
      Color(0xFF355C7D),
    ],

    [
      Color(0xFF134E5E),
      Color(0xFF71B280),
      Color(0xFFCFFFD6),
      Color(0xFFF8FFF8),

      Color(0xFFF8FFF8),
      Color(0xFFCFFFD6),
      Color(0xFF71B280),
      Color(0xFF134E5E),
    ],
    // Existing
    [
      Color(0xFF03001e),
      Color(0xFF7303c0),
      Color(0xFFec38bc),
      // Color(0xFFfdeff9),

      // Color(0xFFfdeff9),
      Color(0xFFec38bc),
      Color(0xFF7303c0),
      Color(0xFF03001e),
    ],

    // Neon Red
    [
      Color(0xFF1a0000),
      Color(0xFFff0844),
      Color(0xFFff5e62),
      // Color(0xFFfff0f0),

      // Color(0xFFfff0f0),
      Color(0xFFff5e62),
      Color(0xFFff0844),
      Color(0xFF1a0000),
    ],

    // Sunset Orange
    [
      Color(0xFF2b0000),
      Color(0xFFff512f),
      Color(0xFFf09819),
      // Color(0xFFfff4d6),

      // Color(0xFFfff4d6),
      Color(0xFFf09819),
      Color(0xFFff512f),
      Color(0xFF2b0000),
    ],

    // Cyber Blue
    [
      Color(0xFF000428),
      Color(0xFF004e92),
      Color(0xFF38bdf8),
      Color(0xFFe0f7ff),

      Color(0xFFe0f7ff),
      Color(0xFF38bdf8),
      Color(0xFF004e92),
      Color(0xFF000428),
    ],

    // Emerald Green
    [
      Color(0xFF001f14),
      Color(0xFF00b09b),
      Color(0xFF96c93d),
      Color(0xFFf3ffe2),

      Color(0xFFf3ffe2),
      Color(0xFF96c93d),
      Color(0xFF00b09b),
      Color(0xFF001f14),
    ],

    // Aqua Mint
    [
      Color(0xFF001f24),
      Color(0xFF00c9a7),
      Color(0xFF92fe9d),
      Color(0xFFf4fff8),

      Color(0xFFf4fff8),
      Color(0xFF92fe9d),
      Color(0xFF00c9a7),
      Color(0xFF001f24),
    ],

    // Purple Dream
    [
      Color(0xFF14001f),
      Color(0xFF8e2de2),
      Color(0xFFc471ed),
      Color(0xFFf7e8ff),

      Color(0xFFf7e8ff),
      Color(0xFFc471ed),
      Color(0xFF8e2de2),
      Color(0xFF14001f),
    ],

    // Royal Indigo
    [
      Color(0xFF09001f),
      Color(0xFF4a00e0),
      Color(0xFF8e54e9),
      Color(0xFFf0ebff),

      Color(0xFFf0ebff),
      Color(0xFF8e54e9),
      Color(0xFF4a00e0),
      Color(0xFF09001f),
    ],

    // Pink Candy
    [
      Color(0xFF240014),
      Color(0xFFff0080),
      Color(0xFFff8cce),
      Color(0xFFfff0f8),

      Color(0xFFfff0f8),
      Color(0xFFff8cce),
      Color(0xFFff0080),
      Color(0xFF240014),
    ],

    // Gold Luxury
    [
      Color(0xFF1f1200),
      Color(0xFFffb347),
      Color(0xFFffd700),
      Color(0xFFfffbe6),

      Color(0xFFfffbe6),
      Color(0xFFffd700),
      Color(0xFFffb347),
      Color(0xFF1f1200),
    ],

    // Ice Blue
    [
      Color(0xFF00141f),
      Color(0xFF00c6ff),
      Color(0xFFb2fefa),
      Color(0xFFf5ffff),

      Color(0xFFf5ffff),
      Color(0xFFb2fefa),
      Color(0xFF00c6ff),
      Color(0xFF00141f),
    ],
  ];
}
