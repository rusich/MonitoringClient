//var
function roundPlus(x, n) { //x - число, n - количество знаков
  if(isNaN(x) || isNaN(n)) return false;
  var m = Math.pow(10,n);
  return Math.round(x*m)/m;
}

function tsToDT(timestamp) {
    var date = new Date(timestamp*1000);
    var hours = date.getHours();
    var minutes = "0" + date.getMinutes();
    var seconds = "0" + date.getSeconds();
    var day = "0"+ date.getDate();
    var month = date.getMonth()+1;
    month = "0" + month;
    var year = date.getFullYear();
    var formattedTime = day.substr(-2) + '/' + month.substr(-2) + '/'+
            year +' ' + hours + ':' + minutes.substr(-2) + ':'
            + seconds.substr(-2);
    return formattedTime;
}
