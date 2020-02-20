{
  selectEmployee: function (args){
    var parameters = args.parameters;
    if(parameters.id == null)
        return {};
        
    var url = '/form/' + parameters.type + '/' + parameters.id;
    return {
        router:{
            push: url
        }
    };
  }
}