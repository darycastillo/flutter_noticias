import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_noticias/src/services/news_services.dart';
import 'package:flutter_noticias/src/widgets/lista_noticias.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
        body: headlines.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ))
            : ListaNoticias(noticias: headlines));
  }

  @override
  bool get wantKeepAlive => true;
}
