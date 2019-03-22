{
  init: function(){
      return {};
  },
  
  generate: function (args){
    var data = args.data;
    var url = '/report/workflow';
    url += "?datefrom=" + data.dateFrom;
    url += "&dateto=" + data.dateTo;
    
    $.get(url).done(function (data) {
        DWKitApp.API.setDataField("grid", data);
    }).fail(function (jqxhr, textStatus, error) {
       alertify.error(textStatus);
    });
    return {};
  }
}