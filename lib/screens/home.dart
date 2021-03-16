import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_store/screens/add_image.dart';
import 'package:image_store/service/authentication.dart';
import 'package:transparent_image/transparent_image.dart';


class HomePage extends StatefulWidget {

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const HomePage({Key key,
    this.auth,
    this.firestore
  }) : super(key: key);



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("photos"),
        centerTitle: true,
        actions: [
          IconButton(
            //key: const ValueKey("signOut"),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Auth(auth: widget.auth).signOut();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddImage()));
        },
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('imageURLs').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  padding: EdgeInsets.all(4),
                  child: GridView.builder(
                      itemCount: snapshot.data.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Card(
                          //elevation: 1.0,
                          child: Container(
                            margin: EdgeInsets.all(3),
                            child: FadeInImage.memoryNetwork(
                                fit: BoxFit.cover,
                                placeholder: kTransparentImage,
                                image: snapshot.data.docs[index].get('url')),
                          ),
                        );
                      }),
                );
              }
            } else {
              return const Center(
                child: Text("loading......"),
              );
            }
          }),
    );
  }
}
