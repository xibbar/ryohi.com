window.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById('monthly-report-show')){
    document.getElementById('monthly_report_print').addEventListener('click', function(){
      document.querySelectorAll('.hidden-print').forEach(function(elm){
        elm.classList.add('print-off');
      });
      window.print();
      document.querySelectorAll('.hidden-print').forEach(function(elm){
        elm.classList.remove('print-off');
      });
    });
  }
});
