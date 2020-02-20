{
   init: function (args){
    var changes = [];
    var token = args.data.PhotoToken;
    if(token)
        changes.push({key: "photo", name: "src", value: "/data/download/" + token});
    
    if(args.data.DateLeft)
          changes.push({key: "leftFlag", name: "style-hidden", value: false });
    
    var res = DWKitApp.API.changeModelControls(args, changes);
    return res;
  },
  changePhoto: function (args){
    var token = args.data.PhotoToken;
    if(token)
        return DWKitApp.API.changeModelControl(args, "photo", "src", "/data/download/" + token);
    else
        return {};
  },
  showsuccess: function (args){
    alertify.success("The email has been sent!");
  },
  validate: function (args){
    var data = args.data;
    DWKitApp.API.formValidate(args);
     
    var hasError = false;
    var errors = {};
   
    if(data.DateJoin != null && data.DateJoin != undefined && 
        data.DateLeft != null && data.DateLeft != undefined && 
        data.DateJoin > data.DateLeft){
        errors.DateLeft = 'DateLeft must be less DateJoin!';
        hasError = true;
    }
    
    if(Array.isArray(data.salaryHistory)){
        var hasSalaryError = false;
        var salaryErrorList = [];
        for(var i=0; i<data.salaryHistory.length; i++){
            var sal = data.salaryHistory[i];
            var item = {
                DateFrom: sal.DateFrom == null,
                DateTo: sal.DateTo == null || sal.DateFrom > sal.DateTo
            };
            
            salaryErrorList.push(item);
            if(item.DateFrom || item.DateTo)
                hasSalaryError = true;
            
        }
        
        if(hasSalaryError){
            errors.salaryHistory = salaryErrorList;
            hasError = true;
        }
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