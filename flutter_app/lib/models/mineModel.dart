class UserModel {
  final int userid;
  final String usercode;
  final String content;
  final String term;

  UserModel.fromJSON(Map<String, dynamic> data) :
        userid = data['userid'],
        usercode = data['usercode'],
        content = data['content'],
        term = data['term'];

  UserModel({this.userid=0,this.usercode='',this.content='',this.term=''});

}