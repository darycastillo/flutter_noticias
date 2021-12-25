import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_noticias/src/models/category_model.dart';
import 'package:flutter_noticias/src/widgets/lista_noticias.dart';
import 'package:flutter_noticias/src/services/news_services.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articlesSelected =
        Provider.of<NewsService>(context).getArticlesSelectedCategory;
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const _ListaCategorias(),
          Expanded(
              child: articlesSelected.isNotEmpty
                  ? ListaNoticias(noticias: articlesSelected)
                  : const Center(child: CircularProgressIndicator()))
        ],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: ListView.builder(
        // physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (_, int index) {
          final cName = categories[index].name;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _CategoryButton(categoria: categories[index]),
                const SizedBox(height: 5),
                Text(
                  '${cName[0].toUpperCase()}${cName.substring(1)}',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;
  const _CategoryButton({
    Key? key,
    required this.categoria,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCategory = Provider.of<NewsService>(
      context,
    ).selectedCategory;

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 80,
        height: 80,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(categoria.icon,
            color: selectedCategory == categoria.name
                ? Theme.of(context).colorScheme.secondary
                : Colors.black54,
            size: 40),
      ),
    );
  }
}
