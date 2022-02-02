import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedidos/providers/auth.dart';
import 'package:pedidos/views/auth_screen.dart';
import 'package:pedidos/views/recebimento_overview_screen.dart';

class ScreenForAuth extends StatelessWidget {
  //const ScreenForAuth({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return FutureBuilder(
      //tenta exec o mét abaixo
      future: auth.autoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return Center(
            child: Text('Ocorreu um erro !'),
          );
        } else {
          // Já q só manda pra outra tela, n preci de Consumer (n é algo ativo)
          return auth.isAuth ? RecebimentoOverviewScreen() : AuthScreen();
        }
      },
    );
  }
}

// Guardar como fazer a build video no youtube
// vieo do github: Como enviar um projeto para o GitHub? (SEM ENROLAÇÃO)


// Já que ScreenForAuth faz parte do contexto da aplicação, após logout há o 
//notifyListners() e então isAuth muda e troca para a tela de login.

// NA VERDADE HÁ O PROBLEMA DE LOGOUT AINDA EM OUTRAS TELAS JÁ Q HÁ O REPLACEMENT
//DEPOIS RESOLVO ISSO.

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// Acredito que no momento que sou jogado nesse widget, esse acaba fazendo parte 
//da aplicação toda e ProductIOverviewScreen() sendo filho dele. Então, no 
//momento que o apago, não posso mais voltar para a tela de autenticação.