import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/order_provider.dart';
import 'screens/orders_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WaslApp());
}

class WaslApp extends StatelessWidget {
  const WaslApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'وين طلبي؟ - وصّل',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0D9488),
            primary: const Color(0xFF0D9488),
            surface: const Color(0xFFF8FAFC),
          ),
          scaffoldBackgroundColor: const Color(0xFFF8FAFC),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF0F172A),
            centerTitle: false,
          ),
        ),
        builder: (context, child) {
          // Force Right-to-Left (RTL) for Arabic experience
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: const OrdersListScreen(),
      ),
    );
  }
}
