{
    init: function(args){
        return DWKitApp.API.changeModelControl(args, 'documentImage', 'src', '/images/businesstrip.svg')
    },
    employeeOnChanged: function({data}){
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
            console.log(data.Employees.length);
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