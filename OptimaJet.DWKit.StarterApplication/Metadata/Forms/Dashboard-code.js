{
  opentrip: function ({parameters}){
    var url = '/form/businesstrip/' + parameters.row.Id;
    return {
        router: {
            push: url
        }
    };
  },
  init: function({data}){
      var numberWithCommas = function(x) {
            x = x.toString();
            var pattern = /(-?\d+)(\d{3})/;
            while (pattern.test(x))
                x = x.replace(pattern, "$1,$2");
            return x;
        };
        
     var compensationChart = {
			datasets: [{
				data: [
				    data.userCompensationAmount,
					data.userCompensationAmountApproved
				],
				backgroundColor: ['#1362E2','#A9D26A'],
				label: 'Compensation'
			}],
			labels: ['Awaiting', 'Approved']
      };
      
      var businessTripChart = {
			datasets: [{
				data: [
				    data.userBusinessTripExpenses,
					data.userBusinessTripExpensesApproved
				],
				backgroundColor: ['#1362E2','#A9D26A'],
				label: 'Compensation'
			}],
			labels: ['Awaiting', 'Approved']
      };
      return {
          app:{
              form: {
                  data: {
                      modified:{
                          compensationChart: compensationChart,
                          businessTripChart: businessTripChart
                      }
                  }
              }
          }
          
      };
  }
}