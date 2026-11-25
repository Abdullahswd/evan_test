import 'package:flutter/material.dart';
import '../utils/formatters.dart';

class OfflineBanner extends StatelessWidget {
  final String? cachedAt;

  const OfflineBanner({super.key, this.cachedAt});

  String _formatCachedTime() {
    if (cachedAt == null) return '';
    final dt = DateTime.tryParse(cachedAt!);
    if (dt == null) return '';
    return ' • آخر مزامنة: ${Formatters.dateTime(dt)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFDE68A),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFFEF3C7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wifi_off_rounded,
              color: Color(0xFFB45309),
              size: 17,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'أنت في وضع عدم الاتصال',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF92400E),
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  'يتم عرض آخر بيانات محفوظة محلياً (غير محدّثة)${_formatCachedTime()}.',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
