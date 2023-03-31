window.addEventListener('DOMContentLoaded', () => {
  if(document.getElementById('schedule-page')){
    document.querySelectorAll('.employee_selection').forEach(function(val, i){
      val.addEventListener('change', function(){
        let da_xhr = new XMLHttpRequest();
        da_xhr.onreadystatechange = setContents;
        da_xhr.open('POST', '/schedules/daily_allowances', true);
        let csrfToken = document.getElementsByName('csrf-token')[0].content;
        da_xhr.setRequestHeader('X-CSRF-Token', csrfToken);
        let formData = new FormData();
        formData.append('employee_id', val.value);
        da_xhr.send(formData);

        function setContents(){
          try {
            if(da_xhr.readyState === XMLHttpRequest.DONE){
              if(da_xhr.status === 200){
                document.getElementById('daily_allowances').innerHTML = da_xhr.responseText;
              }else{
                alert('処理中に問題が発生しました。ページをリロードしてください。');
              }
            }
          }catch(e){
            alert('処理中に問題が発生しました。ページをリロードしてください。');
          }
        }

        accommodationChargesViewControl(val);
      });
    });

    document.getElementById('schedule_days').addEventListener('change', function(){
      const selectedEmployee = document.querySelector('.employee_selection:checked');
      if(selectedEmployee){
        accommodationChargesViewControl(selectedEmployee);
      }
    });

    function accommodationChargesViewControl(target){
      let ac_xhr = new XMLHttpRequest();
      ac_xhr.onreadystatechange = setAccommodationChargeContents;
      ac_xhr.open('POST', '/schedules/accommodation_charges', true);
      let csrfToken = document.getElementsByName('csrf-token')[0].content;
      ac_xhr.setRequestHeader('X-CSRF-Token', csrfToken);
      let acFormData = new FormData();
      acFormData.append('employee_id', target.value);
      acFormData.append('days', document.getElementById('schedule_days').value);
      ac_xhr.send(acFormData);

      function setAccommodationChargeContents(){
        try {
          if(ac_xhr.readyState === XMLHttpRequest.DONE){
            if(ac_xhr.status === 200){
              document.getElementById('accommodation_charges').innerHTML = ac_xhr.responseText;
            }else{
              alert('処理中に問題が発生しました。ページをリロードしてください。');
            }
          }
        }catch(e){
          alert(e.description);
        }
      }
    }
  }

  if(document.getElementById('schedule-show')){
    document.getElementById('schedule-print').addEventListener('click', function(){
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
