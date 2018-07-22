{
  init: function({data, state}){
    var gridName = "grid";
    var controlName = "employedFlag";

    var filter = state.app.form.filters.main != null ? 
        state.app.form.filters.main[gridName] : undefined;
    if(filter == undefined)
        filter = [];
    
    var filterItem = undefined;
    filter.forEach(function(f){
       if(f.__controlName == controlName){
           filterItem = f;
       }
    });
    
    if(filterItem == undefined){
        filterItem = {
            column: "IsLeft",
            term: "=",
            __controlName: controlName
        };
        filter.push(filterItem);
    }
    
    filterItem.nextValue = false;
    filterItem.value = false;
   
    return {
        app: {
            form: {
                filters: {
                    main : {
                        [gridName]: filter
                    }
                }
            }
        }
    };
  },
  employeedFilter: function ({data, state}){
    var gridName = "grid";
    var controlName = "employedFlag";
    var filter = (state.app.form.filters != undefined || state.app.form.filters.main == undefined) ? 
        state.app.form.filters.main[gridName] : undefined;
    if(filter == undefined)
        filter = [];
        
    var filterItem = undefined;
    filter.forEach(function(f){
       if(f.__controlName == controlName){
           filterItem = f;
       }
    });
    
    if(filterItem == undefined){
        filterItem = {
            column: "IsLeft",
            term: "=",
            __controlName: controlName
        };
        filter.push(filterItem);
    }
    
    filterItem.nextValue = !data.employedFlag;
    filterItem.value = !data.employedFlag;
    
    return {
        app: {
            form: {
                filters: {
                    main : {
                        [gridName]: filter
                    }
                }
            }
        }
    };
  }
}