import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  final db = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref;

  Api(this.path) {
    ref = db.collection(path);
  }

  Future<QuerySnapshot> getDocuments() async {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDocuments() {
    return ref.snapshots();
  }

  Stream<DocumentSnapshot> streamDocumentById(id) {
    return ref.doc(id).snapshots();
  }

  Future<QuerySnapshot> getWhereIsEqualTo(param, field) {
    return ref.where(field, isEqualTo: param).get();
  }

  Future<QuerySnapshot> getWhereIsEqualToLimited(param, field, limit) {
    return ref.where(field, isEqualTo: param).limit(limit).get();
  }

  Future<QuerySnapshot> getRecentDocs(uid, timeField) async {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp yesterday = Timestamp.fromDate(
      DateTime.now().subtract(const Duration(days: 1)),
    );

    return ref
        .where(timeField, isLessThan: now, isGreaterThan: yesterday)
        .get();
  }

  Future updateDocument(field, value, docId) {
    return ref.doc(docId).update({field: value});
  }

  Future updateDocumentMap(data, docId) {
    return ref.doc(docId).update(data);
  }

  Future<DocumentSnapshot> getDocumentById(id) {
    return ref.doc(id).get();
  }

  Stream<QuerySnapshot> queryWhereIsEqualTo(param, field) {
    return ref.where(field, isEqualTo: param).snapshots();
  }

  Stream<QuerySnapshot> queryWhereArrayContain(param, field) {
    return ref.where(field, arrayContains: param).snapshots();
  }

  Future<QuerySnapshot> queryIdWhereIn(list) {
    return ref.where(FieldPath.documentId, whereIn: list).get();
  }

  Future<DocumentReference> addData(Map data) {
    return ref.add(data);
  }

  Future setData(Map data, id) {
    return ref.doc(id).set(data);
  }

  Future<QuerySnapshot> queryWhereArrayContainsAndIsEqualTo(
      param, field, value, fieldB) {
    return ref
        .where(fieldB, arrayContains: value)
        .where(field, isEqualTo: param)
        .get();
  }

  Future<QuerySnapshot> queryWhereEqualTox2(param, field, value, fieldB) {
    return ref
        .where(fieldB, isEqualTo: value)
        .where(field, isEqualTo: param)
        .get();
  }

  deleteDocument(id) {
    ref.doc(id).delete();
  }
}
