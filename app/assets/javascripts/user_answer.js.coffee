$(document).ready ->
  $('button.choice').click ->
    $('.choice').removeClass('btn-primary')
    $(this).addClass('btn-primary')

    $('#choice_id').val($(this).attr('data-id'))

    $('#answer_submit_btn').attr('disabled', false)