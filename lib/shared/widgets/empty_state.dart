import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.ctaLabel,
    this.onCta,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? ctaLabel;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppTheme.surfaceVariant,
                borderRadius: BorderRadius.circular(26),
              ),
              alignment: Alignment.center,
              child: CustomPaint(
                size: const Size(38, 42),
                painter: _ShieldEmptyPainter(),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
                letterSpacing: -0.3,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 9),
            Text(
              body,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                height: 1.75,
              ),
              textAlign: TextAlign.center,
            ),
            if (ctaLabel != null && onCta != null) ...[
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: onCta,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 48),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 26, vertical: 14),
                ),
                child: Text(ctaLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ShieldEmptyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primary
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(0, 0, 0, size.height * 0.22);
    path.lineTo(0, size.height * 0.48);
    path.cubicTo(0, size.height * 0.72, size.width * 0.15, size.height * 0.91,
        size.width / 2, size.height);
    path.cubicTo(size.width * 0.85, size.height * 0.91, size.width,
        size.height * 0.72, size.width, size.height * 0.48);
    path.lineTo(size.width, size.height * 0.22);
    path.quadraticBezierTo(size.width, 0, size.width / 2, 0);
    path.close();
    canvas.drawPath(path, paint);

    final checkPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.10
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final checkPath = Path();
    checkPath.moveTo(size.width * 0.27, size.height * 0.50);
    checkPath.lineTo(size.width * 0.44, size.height * 0.64);
    checkPath.lineTo(size.width * 0.73, size.height * 0.37);
    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
