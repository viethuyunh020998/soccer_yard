function ajax_handle_request_booking(url,data)
{
  var token = $('meta[name="csrf-token"]').attr('content')
  $.ajax({
    type: 'PATCH',
    url: url+data.id,
    data: {
      id: data.id,
      stt: data.stt
    },
    dataType: 'JSON',
    headers: {
      "x-csrf-token": token,
    },
  }).done(function (data) {
    Swal.fire(
      'Xác nhận thành công',
      '',
      'success'
    ).then((result) => {
      if (result.isConfirmed) {
        location.reload();
      }
    })
  }).fail(function (data) {
    Swal.fire(
      'Xác nhận thất bại',
      '',
      'error'
    ).then((result) => {
      if (result.isConfirmed) {
        location.reload();
      }
    })
  });
}
$(document).ready(function() {
  $(document).on('click','.handle-request-booking',function(){
    ajax_handle_request_booking("/admin/bookings/",$(this).data())
  });
  $(document).on('click','.handle-cancel-booking',function(){
    ajax_handle_request_booking("/user/bookings/",$(this).data())
  });
});
