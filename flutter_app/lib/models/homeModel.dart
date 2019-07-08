class HomeMenu {

  final String menuname;
  final String pageurl;

  HomeMenu.fromJSON(Map<String, dynamic> data) :
        menuname = data['menuname'],
        pageurl = data['pageurl'];

  HomeMenu({this.menuname='',this.pageurl=''});

}

class SearchListModel {
  final String name,code,start,end,statusstr;
  final int id;
  SearchListModel({this.name,this.code,this.start,this.end,this.statusstr,this.id});
  SearchListModel.fromJSON(Map<String, dynamic> data) :
      name = data['name'],
      code = data['code'],
      start = data['start'],
      end = data['end'],
      id = data['id'],
      statusstr = data['statusstr'];
}