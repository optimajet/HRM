{
  sendinvitation: function({state, data}){
    if(state.app.form.data.original.Email == null ||
        state.app.form.data.original.Email == ""){
        throw {
         level: 1,
         message: "Please, Fill 'Email' field",
         formerrors: {main: {Email: true}}
     };
    }  
    
    var url = '/account/invite?employeeid=' + data.Id;
    $.get(url).done(function (data) {
        if(data.success)
            alertify.success(data.message);
        else
            alertify.error(data.message);
    }).fail(function (jqxhr, textStatus, error) {
       alertify.error(textStatus);
    }); 
    return {};
  },
  changePhoto: function (args){
    var token = args.data.PhotoToken;
    if(token !== undefined && token !== null)
        return DWKitApp.API.changeModelControl(args, "photo", "src", "/data/download/" + token);
    else
        return {};
  },
  
  init: function (args){
    var changes = [];
    var token = args.data.PhotoToken;
    if(token !== null && token !== "")
        changes.push({key: "photo", name: "src", value: "/data/download/" + token});
        
    var res = DWKitApp.API.changeModelControls(args, changes);
    return res;
  },
  
    exit: function(args){
        return {
            router:{
                push: '/form/employees'
            }
        }
    },
  
  opensecurityprofile({data}){
      window.open('/admin?apanel=users&aid=' + data.Id);
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