function roundPlus(x, n) { //x - число, n - количество знаков
  if(isNaN(x) || isNaN(n)) return false;
  var m = Math.pow(10,n);
  return Math.round(x*m)/m;
}
