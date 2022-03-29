import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lmn_neston/database/GetPosts_api.dart';
import 'package:lmn_neston/database/posts_api.dart';
import 'package:lmn_neston/models/AllPosts.dart';
import 'package:lmn_neston/models/CreatePost.dart';
import 'package:provider/provider.dart';

import '../configs/constant.dart';

class Posts extends StatefulWidget {
  // final int indexRequired;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  // Posts(this.indexRequired);
  @override
  // ignore: no_logic_in_create_state
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  // final int indexRequired;
  // _PostsState(this.indexRequired);
  String dropdownValue = "New Posts";

  late List list = [];
  final _fireStore = FirebaseFirestore.instance;
  // late List<CreatePost> _products = [CreatePost()];

  List<CreatePost> _products = <CreatePost>[];
  List<CreatePost> get products => <CreatePost>[..._products];

//   Future<void> getData() async {
//  }

/////////////
  ///
  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            // ignore: unnecessary_null_comparison
            snapshot.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return RefreshIndicator(
          onRefresh: () => getProjectDetails(),
          child: ListView.separated(
            itemCount: _products.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.grey[200],
              thickness: 4,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _products[index].text!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Center(
                        child: Image.network(_products[index].imageUrl!),
                      ),
                      Row(
                        children: [
                          const Text("Learn more about rewards"),
                          const Spacer(),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  appPrimaryColor),
                            ),
                            onPressed: null,
                            child: const Text(
                              'Continue',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      future: getProjectDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return projectWidget();
  }

  ///

// List<CreatePost> allPosts = CreatePost.fromDocument(doc)
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
// // List posts = s
//     // final items = 1000;
//     // getData();
//     PostProvider prodProvider = PostProvider();
//     prodProvider.init();
//     List<CreatePost> _products = prodProvider.products;

//     return FutureBuilder<List<CreatePost>>(
//       future: Provider.of<GetPostsAPI>(context, listen: false).getProducts(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const CircularProgressIndicator();
//         }
//         return RefreshIndicator(
//           child: ListView.separated(
//             itemCount: snapshot.data!.length,
//             separatorBuilder: (BuildContext context, int index) => Divider(
//               color: Colors.grey[200],
//               thickness: 4,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               return Card(
//                 elevation: 2,
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _products[index].text!,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Center(
//                         child: Image.network(_products[index].imageUrl!),
//                       ),
//                       Row(
//                         children: [
//                           const Text("Learn more about rewards"),
//                           const Spacer(),
//                           ElevatedButton(
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   appPrimaryColor),
//                             ),
//                             onPressed: null,
//                             child: const Text(
//                               'Continue',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//           onRefresh: () => prodProvider.refresh(),
//         );
//       },
//     );
//   }

  Future getProjectDetails() async {
    List<CreatePost> projetcList = await someFutureCall();
    _products = projetcList;
    return projetcList;
  }

  someFutureCall() async {
    const String _collection = 'posts';
    final FirebaseFirestore _instance = FirebaseFirestore.instance;

    List<CreatePost> _thisproducts = <CreatePost>[];
    final QuerySnapshot<Map<String, dynamic>> doc =
        await _instance.collection(_collection).get();
    for (DocumentSnapshot<Map<String, dynamic>> element in doc.docs) {
      _thisproducts.add(CreatePost.fromDocument(element));
    }
    return _thisproducts;
  }
}
