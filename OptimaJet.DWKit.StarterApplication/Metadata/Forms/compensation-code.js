{
    init: function(args){
        return DWKitApp.API.changeModelControl(args, 'documentImage', 'src', '/images/compensation.svg')
    },
    exit: function(args){
        return {
            router:{
                push: '/form/compensations'
            }
        }
    }
}