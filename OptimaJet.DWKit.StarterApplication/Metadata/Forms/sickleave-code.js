{
    init: function(args){
        return DWKitApp.API.changeModelControl(args, 'documentImage', 'src', '/images/sickleave.svg')
    },
    exit: function(args){
        return {
            router:{
                push: '/form/sickleaves'
            }
        }
    }
}