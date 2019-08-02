import 'package:flutter/material.dart';

String BaseUrl = "http://192.168.1.236:8080/pmhyapp";

//-----------键值----------------
String kToken = 'z-token';
String kTerm = 'term';
String kNumberOfPage = '10';

Color RGB({r,g,b}) {
  return Color.fromRGBO(r, g, b, 1);
}

Map<String, List<String>> pageUrlMap = {
  "wzjh":[
    "webapp/material/apply/taskapply-shenhe.jsp",
    "webapp/material/apply/taskapply-sh.jsp"
  ],
  "tl":[
    "webapp/material/recede/recede-check.jsp",
    "webapp/material/recede/recede-sp.jsp",
    "webapp/material/recede/recede-check-gqj.jsp",
    "webapp/material/recede/recede-jhy.jsp",
    "webapp/material/recede/recede-end.jsp"
  ],
  "fbjh":[
    "webapp/project/subplan/subplan-zb-apply-sh.jsp",//招标
    "webapp/project/subplan/subplan-zb-ywbldqz.jsp",//招标
    "webapp/project/subplan/subplan-zb-safesh.jsp",
    "webapp/project/subplan/subplan-sd.jsp",
    "webapp/project/subplan/subplan-zjl-sp.jsp"
  ],
  "szht":[
    "webapp/project/bargain/htmk-xzht-gzxzfzrsh.jsp",
    "webapp/project/bargain/htmk-xzht-jyjhbsh.jsp",
    "webapp/project/bargain/htmk-xzht-gzxzfzrshreal.jsp",
    "webapp/project/bargain/htmk-xzht-gzxzzrsh.jsp",
    "webapp/project/bargain/htmk-xzht-jtqygzbzrsh.jsp",
    "webapp/project/bargain/htmk-xzht-ldxzfzzsh.jsp",
    "webapp/project/bargain/htmk-xzht-ldxzzzsh.jsp"
  ],
  "kqgl":[
    "webapp/humresu/timecard/new/timecard-zjl.jsp",
    "webapp/humresu/timecard/new/timecard-bzsh.jsp",
    "webapp/humresu/timecard/bzsp.jsp",
    "webapp/humresu/timecard/new/timecard-jss-sh.jsp",
    "webapp/humresu/timecard/bmsp.jsp",
    "webapp/humresu/timecard/gcbsh.jsp",
    "webapp/humresu/timecard/fgldsh.jsp",
    "webapp/humresu/timecard/zjlsp.jsp",
    "webapp/humresu/timecard/fghzxsp.jsp",
    "webapp/humresu/worktime/attendance.jsp"
  ],
  "rwjd": [
    "webapp/project/taskwork/view.jsp",//任务查看
    "webapp/project/taskwork/toreceive.jsp",//任务接收
    "webapp/project/taskwork/toreceived.jsp",//已接收任务
    "webapp/project/taskwork/bzsh.jsp",//任务工作量班组审核
    "webapp/project/taskwork/jsssp.jsp",//任务工作量技术室审批
    "webapp/project/taskwork/confirm.jsp"//任务工作量确认
  ],
  "ll": [
    "webapp/material/fetch/fetch.jsp",//领料单,在手机端只有“提交”按钮，调审批接口时传P
    "webapp/material/fetch/fetch-check.jsp"//领料单审批
  ]
};
Map<String, MenuType> menus = {
  'wzjh': MenuType(title: '物资计划',imgName: 'assets/wuzijihua.png',bgColor: RGB(r: 242, g: 182, b: 64)
      ,searchVCType: UISearchVCType.wuzi,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
  'fbjh': MenuType(title: '分包计划',imgName: 'assets/fengbaojihua.png',bgColor: RGB(r: 242, g: 182, b: 64)
      ,searchVCType: UISearchVCType.fenbao,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
  'll': MenuType(title: '领料',imgName: 'assets/lingliao.png',bgColor: RGB(r: 238, g: 148, b: 72)
      ,searchVCType: UISearchVCType.wuzi,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
  'tl': MenuType(title: '退料',imgName: 'assets/tuiliao.png',bgColor: RGB(r: 238, g: 148, b: 72)
      ,searchVCType: UISearchVCType.wuzi,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
  'fbjs': MenuType(title: '分包结算',imgName: 'assets/fenbaojiesuan.png',bgColor: RGB(r: 227, g: 103, b: 80)
      ,searchVCType: UISearchVCType.wuzi,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
  'cbjs': MenuType(title: '承包结算',imgName: 'assets/chengbaojiesuan.png',bgColor: RGB(r: 227, g: 103, b: 80)
      ,searchVCType: UISearchVCType.wuzi,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
  'rwjd': MenuType(title: '任务进度',imgName: 'assets/renwujindu.png',bgColor: RGB(r: 89, g: 189, b: 144)
      ,searchVCType: UISearchVCType.renwu,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'start',
            title: '开始时间:',
            placeholder: '请输入开始时间',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'end',
            title: '结束时间:',
            placeholder: '请输入结束时间',
            type: 'string',
            content: ''
        )
      ]),
  'szht': MenuType(title: '收支合同',imgName: 'assets/shouzhihetong.png',bgColor: RGB(r: 227, g: 103, b: 80)
      ,searchVCType: UISearchVCType.hetong,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '合同名称:',
            placeholder: '请输入合同名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '合同编号:',
            placeholder: '请输入合同编号',
            type: 'string',
            content: ''
        )
      ]),
  'dxcb': MenuType(title: '单项成本',imgName: 'assets/danxiangchengben.png',bgColor: RGB(r: 89, g: 189, b: 144)
      ,searchVCType: UISearchVCType.wuzi,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
  'ggtzd': MenuType(title: '规格调整单',imgName: 'assets/anquanzhiliangjiancha.png',bgColor: RGB(r: 85, g: 158, b: 244)
      ,searchVCType: UISearchVCType.wuzi,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
  'phlk': MenuType(title: '平衡利库',imgName: 'assets/pinghengliku.png',bgColor: RGB(r: 85, g: 158, b: 244)
      ,searchVCType: UISearchVCType.wuzi,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
  'cght': MenuType(title: '采购合同',imgName: 'assets/caigouhetong.png',bgColor: RGB(r: 227, g: 103, b: 80)
      ,searchVCType: UISearchVCType.hetong,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '合同名称:',
            placeholder: '请输入合同名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '合同编号:',
            placeholder: '请输入合同编号',
            type: 'string',
            content: ''
        )
      ]),
  'rkd': MenuType(title: '入库单',imgName: 'assets/rukudan.png',bgColor: RGB(r: 85, g: 158, b: 244)
      ,searchVCType: UISearchVCType.wuzi,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
  'cbgc': MenuType(title: '承包工程',imgName: 'assets/chnegbaogongcheng.png',bgColor: RGB(r: 89, g: 189, b: 144)
      ,searchVCType: UISearchVCType.hetong,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '合同名称:',
            placeholder: '请输入合同名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '合同编号:',
            placeholder: '请输入合同编号',
            type: 'string',
            content: ''
        )
      ]),
  'kqgl': MenuType(title: '考勤管理',imgName: 'assets/kaoqinguanli.png',bgColor: RGB(r: 85, g: 158, b: 244)
      ,searchVCType: UISearchVCType.kaoqing,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '申请人:',
            placeholder: '请输入申请人',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'start',
            title: '开始时间:',
            placeholder: '请输入开始时间',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'end',
            title: '结束时间:',
            placeholder: '请输入结束时间',
            type: 'string',
            content: ''
        )
      ]),
  'rwjggl': MenuType(title: '任务竣工管理',imgName: 'assets/anquanzhiliangjiancha.png',bgColor: RGB(r: 85, g: 158, b: 244)
      ,searchVCType: UISearchVCType.wuzi,searchInputs: [
        SearchInput(
            paramKey: 'name',
            title: '任务名称:',
            placeholder: '请输入任务名称',
            type: 'string',
            content: ''
        ),
        SearchInput(
            paramKey: 'code',
            title: '任务编号:',
            placeholder: '请输入任务编号',
            type: 'string',
            content: ''
        )
      ]),
};

class MenuType {
  String title = '';
  String imgName = '';
  Color bgColor = Colors.white;
  List<SearchInput> searchInputs;
  UISearchVCType searchVCType;
  MenuType({
    Key key,
    this.title,
    this.imgName,
    this.bgColor,
    this.searchInputs,
    this.searchVCType
  });
}
class SearchInput {
  String paramKey,title,placeholder,type,content;
  SearchInput({
    Key key,
    this.paramKey,
    this.title,
    this.placeholder,
    this.type,
    this.content
  });
}

enum UISearchVCType {
  wuzi,
  hetong,
  kaoqing,
  renwu,
  fenbao
}