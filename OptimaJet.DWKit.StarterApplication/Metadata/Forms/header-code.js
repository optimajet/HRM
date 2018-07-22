{
  selectEmployee: function ({parameters}){
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