{
    init: function(args){
        return DWKitApp.API.changeModelControl(args, 'documentImage', 'src', '/images/businesstrip.svg')
    },
    employeeOnChanged: function(args){
        var data = args.data;
        if(Array.isArray(data.Employees)){
            return {
                app:{
                    form: {
                        data: {
                            modified:{
                                PeopleCount: data.Employees.length
                            }
                        }
                    }
                }
            };
        }
        
        return {};
    },
    exit: function(args){
        return {
            router:{
                push: '/form/businesstrips'
            }
        }
    }
}