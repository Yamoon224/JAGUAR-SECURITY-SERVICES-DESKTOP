import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';

const String kAdminUrl = 'https://admin.jss-gn.com';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JaguarAdminApp());
}

class JaguarAdminApp extends StatelessWidget {
  const JaguarAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jaguar Security Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF960000)),
      home: const AdminPage(),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _controller = WebviewController();
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await _controller.initialize();
      await _controller.setBackgroundColor(Colors.white);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.sameWindow);
      await _controller.loadUrl(kAdminUrl);
      if (mounted) setState(() {});
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Impossible de charger l\'application.\n'
              'Vérifiez que Microsoft Edge WebView2 est installé et que vous êtes connecté à Internet.\n\n$_error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    if (!_controller.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    // Le site occupe toute la fenêtre, sans barre ni marge.
    return Scaffold(body: Webview(_controller));
  }
}
