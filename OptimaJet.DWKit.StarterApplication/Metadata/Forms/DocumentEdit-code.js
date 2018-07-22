{
    initWorkflow: function (args){
        var state = args.state;
        var parameters = args.parameters;
        var isManageThisDocument = false;
        if(Array.isArray(parameters.commands)){
            for(var i = 0; i < parameters.commands.length; i++){
                if(parameters.commands[i].type == 1){
                    isManageThisDocument = true;
                    break;
                }
            }
        }
            
        var savebuttons = ["Save", "SaveExit"];
        if(isManageThisDocument){
            var changes = [];
            savebuttons.forEach(function(item){
               changes.push({key: item, name: 'style-hidden', value: false});
            });
            
            return DWKitApp.API.changeModelControls(args, changes);
        }
        
        return {
            app: {
                form: {
                    models: {
                        readOnly: !isManageThisDocument
                    }
                }
            }
        };
    },
    openworkflowdesginer: function (args) {
        var url = "/admin?apanel=workflowinstances&aid=" + args.data.Id;
        return {
            router: {
                redirect: url
            }
        };
    }

}