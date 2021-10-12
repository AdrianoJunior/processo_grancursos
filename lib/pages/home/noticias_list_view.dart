import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grancursos/pages/home/noticia_page.dart';
import 'package:grancursos/utils/nav.dart';
import 'package:grancursos/utils/text_styles.dart';
import 'package:intl/intl.dart';

import 'noticia.dart';

class NoticiasListView extends StatelessWidget {
  var data;

  NoticiasListView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: data != null ? data.size : 0,
        itemBuilder: (context, index) {
          Noticia n = data.docs[index].data();
          final f = DateFormat('dd/MM/yyyy');
          return Container(
            padding: EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                push(context, NoticiaPage(noticia: n));
              },
              child: Card(
                elevation: 16,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 250,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: n.photoUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(f.format(n.postDate!.toDate()),
                            style: TextStyles().dateStyle(), maxLines: 3),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Text(n.title ?? "",
                            style: TextStyles().titleStyle()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Text(
                          n.text ?? "",
                          style: TextStyles().descStyle(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
