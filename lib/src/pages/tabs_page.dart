import 'package:flutter/material.dart';
import 'package:flutter_noticias/src/pages/tab1_page.dart';
import 'package:flutter_noticias/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
      currentIndex: navigationProvider.paginaActual,
      onTap: (index) => navigationProvider.paginaActual = index,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Para ti"),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: "Encabezados")
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<_NavegacionModel>(context);
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      // physics: const BouncingScrollPhysics(),
      controller: navigationProvider.pageController,
      children: const [Tab1Page(), Tab2Page()],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController(initialPage: 0);

  int get paginaActual => _paginaActual;

  set paginaActual(int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 250),
        curve: Curves.fastOutSlowIn);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
