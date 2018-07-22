{
  init: function (args /*{data, originalData, state, component, formName, index, controlRef, eventArgs, isChild}*/){
    var path = args.state.router.location.pathname.split('/');
    var filter = path[path.length - 1];
    var header = undefined;
    if(filter === "inbox"){
        header = "Inbox";
    }
    else if(filter === "outbox"){
        header = "Outbox";
    }
    
    if(header !== undefined){
        var changes = [];
        changes.push({key: "pageHeader", name: "content", value: header});
        return DWKitApp.API.changeModelControls(args, changes);
    }
    
    return {};
  },

  edit: function ({parameters}){
    var type = parameters.row.Type;
    var form = undefined;
    form = type.toLowerCase();  
    
    var res = {};
    if(form === undefined){
        alertify.error("Unknown document type: " + type + "!");
    }
    else{
        var url = '/form/' + form + "/" + parameters.row.Id;
        res = {
            router: {
                push: url
            }
        };
    }
    return res;
  }
}