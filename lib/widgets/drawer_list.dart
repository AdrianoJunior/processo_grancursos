import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:grancursos/firebase/firebase_service.dart';
import 'package:grancursos/pages/eventos/eventos_page.dart';
import 'package:grancursos/pages/home/home_page.dart';
import 'package:grancursos/pages/login/login_page.dart';
import 'package:grancursos/pages/login/recover_page.dart';
import 'package:grancursos/pages/login/usuario.dart';
import 'package:grancursos/pages/perfil/profile_page.dart';
import 'package:grancursos/utils/nav.dart';

class DrawerList extends StatelessWidget {
  String defaultImage =
      "https://firebasestorage.googleapis.com/v0/b/grancursos-9ede7."
      "appspot.com/o/defaults%2Fdefault_image.png?alt=media&token="
      "df9bad88-5d3b-4039-b0ab-d1a6f033e3e6";
  User? user = FirebaseAuth.instance.currentUser;

  /*UserAccountsDrawerHeader?*/
  _header() {
    return user != null
        ? UserAccountsDrawerHeader(
            accountName: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                user != null ? user!.displayName ?? "Nome" : "Nome",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            accountEmail:
                Text(user != null ? user!.email ?? "E-mail" : "E-mail"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                user != null ? user!.photoURL ?? defaultImage : defaultImage,
              ),
            ),
          )
        : Container(
            height: 175,
            color: Colors.red,
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            _header(),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesome.newspaper_o,
                  color: Colors.black,
                ),
              ),
              title: const Text("Notícias"),
              onTap: () {
                pop(context);
                push(context, HomePage());
              },
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  MaterialIcons.event,
                  color: Colors.black,
                ),
              ),
              title: const Text("Eventos"),
              onTap: () {
                pop(context);
                push(context, EventosPage());
              },
            ),
            user != null
                ? ExpansionTile(
                    leading: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Ionicons.md_person_circle_sharp,
                        color: Colors.black,
                      ),
                    ),
                    title: const Text("Perfil"),
                    children: [
                      ListTile(
                        title: const Text("Meus dados"),
                        leading: const Icon(
                          MaterialCommunityIcons.account_edit,
                          color: Colors.black,
                        ),
                        onTap: () {
                          pop(context);
                          push(context, ProfilePage());
                        },
                      ),
                      ListTile(
                        title: const Text("Trocar senha"),
                        leading: const Icon(
                          Ionicons.md_key,
                          color: Colors.black,
                        ),
                        onTap: () {
                          pop(context);
                          push(context, RecoverPage());
                        },
                      ),
                      ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            MaterialCommunityIcons.exit_to_app,
                            color: Colors.black,
                          ),
                        ),
                        title: const Text("Logout"),
                        onTap: () async {
                          pop(context);
                          await _onClickLogout();
                          push(context, HomePage(), replace: true);
                        },
                      ),
                    ],
                  )
                : ListTile(
                    title: const Text("Entrar"),
                    onTap: () {
                      pop(context);
                      push(context, LoginPage());
                    },
                    leading: const Icon(
                      FontAwesome.sign_in,
                      color: Colors.black,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _onClickLogout() async {
    Usuario.clear();
    await FirebaseService().logout();
  }
}
