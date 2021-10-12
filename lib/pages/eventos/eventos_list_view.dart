import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grancursos/pages/eventos/evento.dart';
import 'package:grancursos/pages/eventos/evento_page.dart';
import 'package:grancursos/utils/nav.dart';
import 'package:grancursos/utils/text_styles.dart';
import 'package:intl/intl.dart';

class EventosListView extends StatelessWidget {
  var data;

  EventosListView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data != null ? data.size : 0,
        itemBuilder: (context, index) {
          Evento e = data.docs[index].data();

          print("EVENTO >>>>>> ${e.toString()}\n\n");
          final f = DateFormat('dd/MM/yyyy');
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                push(context, EventoPage(evento: e));
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
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 8),
                        child: Text(
                          e.name ?? "",
                          style: TextStyles().titleStyle(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(f.format(e.eventDate!.toDate()),
                            style: TextStyles().dateStyle(), maxLines: 3),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          e.desc ?? "",
                          style: TextStyles().descStyle(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Container(
                          height: 250,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: e.photoUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
