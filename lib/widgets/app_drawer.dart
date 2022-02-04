import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/auth.dart';
import 'package:pedidos/utils/app_routes.dart';

// A alteração de tirar o Replacement pode fazer com que, talvez, as telas fiquem
//na memória e sobrecarregue a aplicação.

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('MENU'),
          ),
          ListTile(
            leading: Icon(Icons.receipt_long_outlined),
            title: Text('Recebimentos'),
            onTap: () =>
                // INVÉS DE FAZER STACK, SUBSTITUI A TELA POR OUTRA
                Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('sair da conta'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.SCREEN_FOR_AUTH);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
