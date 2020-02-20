{
//  validate: function ({data, originalData, state, component, formName, index, controlRef, eventArgs, isChild}){
//    var errors = {};
//    //TODO: Insert your code for validation this form
//    if(data.name == undefined || data.name == ''){
//      errors.name = 'This field is required!';
//    }
//    if(errors.name){
//      throw {
//          level: 1,
//          message: 'Check errors on the form!',
//          formerrors: {main: errors}
//      };
//    }
//    return {};
//  },

  resetForm: function (args){
    setTimeout(function(){
        DWKitApp.API.executeActionsDispatch({actions:["redirect"], parameters: {target: "/form/department/"}})
    }, 0);
  },

  refreshMainGrid: function (args){
      if(args.component && args.component.refs && args.component.refs.grid)
        args.component.refs.grid.refresh();
  }
}