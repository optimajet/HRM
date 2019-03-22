{
  init: function (args){
    var path = args.state.router.location.pathname.split('/');
    var filter = path[path.length - 1];
    var header = undefined;
    if(filter === "inbox"){
        header = DWKitLang != undefined && DWKitLang.forms != undefined && 
                DWKitLang.forms.Documents != undefined && 
                DWKitLang.forms.Documents.inbox != undefined ?
            DWKitLang.forms.Documents.inbox : "Inbox";
    }
    else if(filter === "outbox"){
        header = DWKitLang != undefined && DWKitLang.forms != undefined && 
                DWKitLang.forms.Documents != undefined && 
                DWKitLang.forms.Documents.outbox != undefined ?
            DWKitLang.forms.Documents.outbox : "Outbox";
    }
    
    if(header !== undefined){
        var changes = [];
        changes.push({key: "pageHeader", name: "content", value: header});
        return DWKitApp.API.changeModelControls(args, changes);
    }
    
    return {};
  },

  edit: function (args){
    var parameters = args.parameters;
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