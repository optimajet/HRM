{
    init: function(args){
        return DWKitApp.API.changeModelControl(args, 'documentImage', 'src', '/images/recruitment.svg')
    },
    exit: function(args){
        return {
            router:{
                push: '/form/recruitments'
            }
        }
    }
}