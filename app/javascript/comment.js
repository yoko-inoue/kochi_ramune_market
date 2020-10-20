$(function(){
  function buildHTML(comment){
    let html = `<div class="comment-info">
                  <strong>
                    ${comment.user_name}
                    ：
                    ${comment.text}
                  </strong>
                  <div>
                    ${comment.created_at}
                  </div>
                </div>`
    return html;
  }

  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })

    .done(function(data){
      let html = buildHTML(data);
      $('.comments__list').prepend(html);
      $('.textbox').val('');
      $('.form__submit').prop('disabled', false);
    })

    .fail(function(){
      alert('error');
    })
  })
});