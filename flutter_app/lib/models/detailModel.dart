class HeTongModel {
  final String address,bgncode,bgnname,second,
      signdate,createdate,bgnvalueStr,shuilv,bgntype,remark,deptname;
  final int first,jsfs;
  final double bgnvalue;
  HeTongModel({
    this.address,
    this.bgncode,
    this.bgnname,
    this.second,
    this.signdate,
    this.createdate,
    this.bgnvalueStr,
    this.first,
    this.bgnvalue,
    this.shuilv,
    this.bgntype,
    this.jsfs,
    this.remark,
    this.deptname
  });
  HeTongModel.fromJSON(Map<String, dynamic> data) :
        deptname = data['deptname'] != null ? data['deptname'] : '',
        address = data['address'] != null ? data['address'] : '',
        bgncode = data['bgncode'] != null ? data['bgncode'] : '',
        bgnname = data['bgnname'] != null ? data['bgnname'] : '',
        second = data['second'] != null ? data['second'] : '',
        signdate = data['signdate'] != null ? data['signdate'] : '',
        createdate = data['createdate'] != null ? data['createdate'] : '',
        bgnvalueStr = data['bgnvalueStr'] != null ? data['bgnvalueStr'] : '',
        first = data['first'] != null ? data['first'] : '',
        bgnvalue = data['bgnvalue'] != null ? data['bgnvalue'] : '',
        shuilv = data['shuilv'] != null ? data['shuilv'] : '',
        bgntype = data['bgntype'] != null ? data['bgntype'] : '',
        jsfs = data['jsfs'] != null ? data['jsfs'] : '',
        remark = data['remark'] != null ? data['remark'] : '';
}

class HRModel {
  final String username,typename,applydate,
      startdate,enddate,ramark;
  final String applydays,applyhours,overdate,reason,deptname;
  HRModel({
    this.username,
    this.typename,
    this.deptname,
    this.applydate,
    this.applydays,
    this.applyhours,
    this.enddate,
    this.overdate,
    this.reason,
    this.startdate,
    this.ramark
  });
  HRModel.fromJSON(Map<String, dynamic> data) :
        username = data['username'] != null ? data['username'].toString() : '',
        typename = data['typename'] != null ? data['typename'].toString() : '',
        deptname = data['deptname'] != null ? data['deptname'].toString() : '',
        applydate = data['applydate'] != null ? data['applydate'].toString() : '',
        applydays = data['applydays'] != null ? data['applydays'].toString() : '',
        applyhours = data['applyhours'] != null ? data['applyhours'].toString() : '',
        enddate = data['enddate'] != null ? data['enddate'].toString() : '',
        overdate = data['overdate'] != null ? data['overdate'].toString() : '',
        reason = data['reason'] != null ? data['reason'].toString() : '',
        ramark = data['ramark'] != null ? data['ramark'].toString() : '',
        startdate = data['startdate'] != null ? data['startdate'].toString() : '';
}

class FenBaoModel {
  final String subplanid,taskid,status,taskcode,taskname,projectcode,
      projectname,protype,itemcode,itemid,itemname,
      comid,comcode,comname,zzjgcode,lxr,lxrphone,szaddress,
      subtype,fbjiesuantype,planvalue,planvalueStr,
      factvalue,subcontent,subplancode,remark,peoples,jttlly,
      org,reason,zbname,lowRllv,feilv,xianjia;
  FenBaoModel({
    this.reason,
    this.remark,
    this.comcode,
    this.comid,
    this.taskcode,
    this.comname,
    this.factvalue,
    this.fbjiesuantype,
    this.itemcode,
    this.itemid,
    this.itemname,
    this.jttlly,
    this.lxr,
    this.lxrphone,
    this.org,
    this.peoples,
    this.planvalue,
    this.planvalueStr,
    this.projectcode,
    this.projectname,
    this.protype,
    this.status,
    this.subcontent,
    this.subplancode,
    this.subplanid,
    this.subtype,
    this.szaddress,
    this.taskid,
    this.taskname,
    this.zzjgcode,
    this.zbname,
    this.lowRllv,
    this.feilv,
    this.xianjia
  });
  FenBaoModel.fromJSON(Map<String, dynamic> data) :
        reason = data['reason'] != null ? data['reason'].toString() : '',
        remark = data['remark'] != null ? data['remark'].toString() : '',
        comcode = data['comcode'] != null ? data['comcode'].toString() : '',
        comid = data['comid'] != null ? data['comid'].toString() : '',
        taskcode = data['taskcode'] != null ? data['taskcode'].toString() : '',
        comname = data['comname'] != null ? data['comname'].toString() : '',
        factvalue = data['factvalue'] != null ? data['factvalue'].toString() : '',
        fbjiesuantype = data['fbjiesuantype'] != null ? data['fbjiesuantype'].toString() : '',
        itemcode = data['itemcode'] != null ? data['itemcode'].toString() : '',
        itemid = data['itemid'] != null ? data['itemid'].toString() : '',
        itemname = data['itemname'] != null ? data['itemname'].toString() : '',
        jttlly = data['jttlly'] != null ? data['jttlly'].toString() : '',
        lxr = data['lxr'] != null ? data['lxr'].toString() : '',
        lxrphone = data['lxrphone'] != null ? data['lxrphone'].toString() : '',
        org = data['org'] != null ? data['org'].toString() : '',
        peoples = data['peoples'] != null ? data['peoples'].toString() : '',
        planvalue = data['planvalue'] != null ? data['planvalue'].toString() : '',
        planvalueStr = data['planvalueStr'] != null ? data['planvalueStr'].toString() : '',
        projectcode = data['projectcode'] != null ? data['projectcode'].toString() : '',
        projectname = data['projectname'] != null ? data['projectname'].toString() : '',
        protype = data['protype'] != null ? data['protype'].toString() : '',
        status = data['status'] != null ? data['status'].toString() : '',
        subcontent = data['subcontent'] != null ? data['subcontent'].toString() : '',
        subplancode = data['subplancode'] != null ? data['subplancode'].toString() : '',
        subplanid = data['subplanid'] != null ? data['subplanid'].toString() : '',
        subtype = data['subtype'] != null ? data['subtype'].toString() : '',
        szaddress = data['szaddress'] != null ? data['szaddress'].toString() : '',
        taskid = data['taskid'] != null ? data['taskid'].toString() : '',
        feilv = data['feilv'] != null ? data['feilv'].toString() : '',
        taskname = data['taskname'] != null ? data['taskname'].toString() : '',
        lowRllv =  data['lowRllv'] != null ? data['lowRllv'].toString() : '',
        xianjia =  data['xianjia'] != null ? data['xianjia'].toString() : '',
        zbname = data['zbname'] != null ? data['zbname'].toString() : '',
        zzjgcode = data['zzjgcode'] != null ? data['zzjgcode'].toString() : '';
}

class WuZiModel {
  final String recedeid,detailid,matid,amount,matcode,matname;
  WuZiModel({
    this.amount,
    this.detailid,
    this.matcode,
    this.matid,
    this.matname,
    this.recedeid
  });
  WuZiModel.fromJSON(Map<String,dynamic> data) :
        amount = data['amount'] != null ? data['amount'].toString() : '',
        detailid = data['detailid'] != null ? data['detailid'].toString() : '',
        matcode = data['matcode'] != null ? data['matcode'].toString() : '',
        matid = data['matid'] != null ? data['matid'].toString() : '',
        matname = data['matname'] != null ? data['matname'].toString() : '',
        recedeid = data['recedeid'] != null ? data['recedeid'].toString() : '';
}