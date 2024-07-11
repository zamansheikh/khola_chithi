import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khola_chithi/x_old/post_model.dart';

// ignore: constant_identifier_names
const String NOTE_COLLECTION_REF = "posts";
// ignore: constant_identifier_names
const String USER_COLLECTION_REF = "users";

class FireStoreService  {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _notesRef;

  //addUser
  void addUser(String uid, String email, String name) {
    _firestore.collection(USER_COLLECTION_REF).doc(uid).set({
      'email': email,
      'uid': uid,
      'name': name,
    });
  }

  FireStoreService() {
    _notesRef =
        _firestore.collection(NOTE_COLLECTION_REF).withConverter<PostModel>(
              fromFirestore: (snapshots, _) => PostModel.fromJson(
                snapshots.data()!,
              ),
              toFirestore: (posts, _) => posts.toJson(),
            );
  }

  Stream<QuerySnapshot> getPostsLimit(
      {DocumentSnapshot? lastDoc, int limit = 3}) {
    Query query =
        _firestore.collection('posts').orderBy('createdAt').limit(limit);
    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }
    return query.snapshots();
  }

  //create function to fetch last post

  Stream<QuerySnapshot> getLastPost() {
    Query query = _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(1);
    return query.snapshots();
  }

  Stream<QuerySnapshot> getPosts() {
    return _notesRef.snapshots();
  }

  Future<void> addPost(PostModel post) async {
    await _notesRef.add(post);
  }

  Future<void> deletePost(String id) async {
    await _notesRef.doc(id).delete();
  }

  Future<void> updatePost(String id, PostModel post) async {
    await _notesRef.doc(id).update(post.toJson());
  }
}
