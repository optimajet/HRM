{
    init: function(args){
        return DWKitApp.API.changeModelControls(args, [
            {key: 'documentImage', name:'src', value:'/images/vacation.svg'},
            {key: 'pageHeader', name:'content', value:'{EmployeeId_Name}'},
            ]);
    },
    exit: function(args){
        return {
            router:{
                push: '/form/vacations'
            }
        }
    }
}