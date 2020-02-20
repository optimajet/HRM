{
    init: function() {
        return {};
  },
  
  generate: function (args){
    DWKitApp.API.setDataField("grid", {}, args.modalId);
    
    let callback = function(response){
        if(!response.success){
            alertify.error(response.message);
            return;
        }
        
        var data = response.result.stateDelta.app.form.data.modified.grid;
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
        DWKitApp.API.setDataField("grid", data, args.modalId);
    };
      
    return DWKitApp.API.callServerCodeAction("EmployeeReport", {data: args.data}, callback, false, true);
  },
  edit: function (args){
    window.open('/form/employee/' + args.parameters.row.Id);
    return {};
  }
}