{
    init: function() {
        return {};
  },
  
  generate: function (args){
    var data = args.data;
    var errors = {main: {}};
    if(data === null)
        data = {};
        
    if(data.dateFrom === undefined || data.dateFrom === ''){
        errors.main.dateFrom = 'This field is required!';
    }
    
    if(data.dateTo === undefined || data.dateTo === ''){
        errors.main.dateTo = 'This field is required!';
    }
    
    if(errors.main.dateFrom || errors.main.dateTo){
        throw {
         level: 1,
         message: 'Check errors on the form!',
         formerrors: errors
        };
    }

    var url = '/report/employee';
    url += "?datefrom=" + data.dateFrom;
    url += "&dateto=" + data.dateTo;
    url += "&parameter=" + data.parameter;
    url += "&period=" + data.period;
    
    $.get(url).done(function (data) {
        var gridModelRewriter = function (model){
            model.columns = [];
            if(Array.isArray(data) && data.length > 0){
                for(var p in data[0]){
                    if(p == "Id") continue;
                    model.columns.push(
                        {key: p, name: p, resizable: true, width: 150, sortable: true}
                    );
                }
            }
        }
        DWKitApp.API.rewriteControlModel("grid", gridModelRewriter);
        DWKitApp.API.setDataField("grid", data);
        
    }).fail(function (jqxhr, textStatus, error) {
       alertify.error(textStatus);
    });
    return {};
  },
  edit: function (args){
    var parameters = args.parameters;
    return {
        router: {
            push: '/form/employee/' + parameters.row.Id
        }
    };
  }
}