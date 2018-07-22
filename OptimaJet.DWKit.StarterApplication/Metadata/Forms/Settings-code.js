{
 validate: function ({data, originalData, state, component, formName, index, controlRef, eventArgs, isChild}){
    var errors = {};
    var hasError = false;
    if(Array.isArray(data.taxGrid)){
        errors.taxGrid = [];
        data.taxGrid.forEach(function(item){
            var itemError = {};
            if(item.AverageTaxRate == null){
                itemError.AverageTaxRate = 'This field is requered!';
                hasError = true;
            }
            errors.taxGrid.push(itemError);
        });
    }
    
    if(hasError){
     throw {
         level: 1,
         message: 'Check errors on the form!',
         formerrors: {main: errors}
     };
    }
    return {};
 }
}