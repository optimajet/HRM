{
    init: function(args){
        return DWKitApp.API.changeModelControl(args, 'documentImage', 'src', '/images/businesstrip.svg');
    },
    employeeOnChanged: function(args){
        var data = args.data;
        if (Array.isArray(data.Employees)) {
            data.PeopleCount = data.Employees.length           
        }
        
        return {};
    }
}