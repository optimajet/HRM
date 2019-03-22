{
  init: function(){
      var date = new Date();
      return {
          app:{
            form:{
                data:{
                    modified:{
                        dateFrom: date.getFullYear() + "-" + (date.getMonth() - 4 + 1) + "-" + 1,
                        dateTo: date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate(),
                    }
                }
            }
          }
      };
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