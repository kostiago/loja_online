import 'package:flutter/material.dart';
import 'package:lojavirtual/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/models/home_manager.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/screens/base/home/components/section_list.dart';
import 'package:lojavirtual/screens/base/home/components/section_staggered.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: const [
                      Color.fromARGB(255, 211, 118, 130),
                      Color.fromARGB(255, 253, 181, 168)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Sua Loja'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                  Consumer2<UserManager, HomeManager>(
                    builder: (_,userManager, homeManager,__){
                      if(userManager.adminEnabled){
                        if(homeManager.editing)
                          return PopupMenuButton(
                            onSelected: (e){
                              if(e == 'Salvar'){
                                homeManager.saveEditing();
                              }
                              else{
                                homeManager.discardEditing();
                              }
                            },
                            itemBuilder: (_){
                              return['Salvar','Apagar'].map((e){
                                return PopupMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList();
                            },
                          );
                        else {
                          return IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: homeManager.enterEditing,
                          );
                        }
                      }
                      else return Container();
                    },
                  ),
                ],
              ),

              Consumer<HomeManager>(
                builder: (_, homeManager, __){
                  final List<Widget> children = homeManager.sections.map<Widget>(
                          (section) {
                        switch(section.type){
                          case 'List':
                            return SectionList(section);
                          case 'Staggered':
                            return SectionStaggered(section);
                          default:
                            return Container();
                        }
                      }
                  ).toList();

                  return SliverList(
                    delegate: SliverChildListDelegate(children),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}