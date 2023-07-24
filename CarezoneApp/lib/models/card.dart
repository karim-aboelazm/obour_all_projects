class CardModel {
  String doctor;
  String image;


  CardModel(this.doctor, this.image);
}

List<CardModel> cards = [
  CardModel('What is a brain tumor and its types?',
      'images/card3.jpg'),
  CardModel(
      'What causes brain tumors?And his treatment',
      'images/333jpg.jpg'
      ),
  CardModel('Getting better after treatment for brain tumours', 'images/2222.jpg'),
  CardModel('tests will be done to diagnose a brain tumor', 'images/image-medical.jpg'),

];
