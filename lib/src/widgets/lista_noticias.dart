import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_noticias/src/models/news_models.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias({Key? key, required this.noticias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (_, int index) {
        return _Noticia(
          index: index,
          noticia: noticias[index],
        );
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;
  const _Noticia({Key? key, required this.noticia, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopbar(noticia: noticia, index: index),
        _TarjetaTitulo(
          noticia: noticia,
        ),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        const _TarjetaBotones(),
        const SizedBox(
          height: 10,
        ),
        const Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RawMaterialButton(
              onPressed: () {},
              child: const Icon(Icons.star_border),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              fillColor: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              width: 10,
            ),
            RawMaterialButton(
              onPressed: () {},
              child: const Icon(Icons.more_outlined),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              fillColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ));
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;
  const _TarjetaBody({
    Key? key,
    required this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(noticia.description ?? ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  const _TarjetaImagen({
    Key? key,
    required this.noticia,
  }) : super(key: key);

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), bottomRight: Radius.circular(50)),
        child: Container(
            child: noticia.urlToImage != null
                ? FadeInImage(
                    image: NetworkImage(noticia.urlToImage ?? ''),
                    placeholder: const AssetImage("assets/img/giphy.gif"))
                : const Image(image: AssetImage("assets/img/no-image.png"))),
      ),
    );
  }
}

class _TarjetaTopbar extends StatelessWidget {
  final Article noticia;
  final int index;
  const _TarjetaTopbar({
    Key? key,
    required this.noticia,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text(
          '${index + 1}',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        const SizedBox(width: 50),
        Text(noticia.source.name)
      ]),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}
