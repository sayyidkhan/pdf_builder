class PdfDB {
  int id;
  String fileName;
  String filePath;

  Map<String,dynamic> toMap() {
    var map = <String, dynamic> {
      'id' : id,
      'fileName' : fileName,
      'filePath' : filePath,
    };
    return map;
  }

  PdfDB.fromMap(Map<String,dynamic> map){
    id = map['id'];
    fileName = map['fileName'];
    filePath = map['filePath'];
  }

  PdfDB(this.id, this.fileName,this.filePath);
}

class PdfDBCounter {
  int counter;

  PdfDBCounter(this.counter);
}