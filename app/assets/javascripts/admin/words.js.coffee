$(document).ready ->
  remove_field_handler = (event) ->
    parent = $(this).parent()
    parent.hide()
    parent.find("input[type='hidden']").val(1)
    event.preventDefault()

  $(".remove-fields-btn").on "click", remove_field_handler

  $(".add-fields-btn").on "click", (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))

    $(".remove-fields-btn").off("click", remove_field_handler)
      .on("click", remove_field_handler)

    event.preventDefault()