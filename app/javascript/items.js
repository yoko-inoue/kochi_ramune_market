$(window).on('load', ()=> {

  function buildFileField(index) {
    const html = `<div class="file" data-index="${index}">
                    <input id="item_images_attributes_${index}_image_url" class="file__image" type="file"
                    name="item[images_attributes][${index}][image_url]" data-index="${index}" required="required">
                  </div>`;
    return html;
  }



  function buildImg(index, url) {
    const html = `<div data-index="${index}" class="previews__field count-box" data-count="${index}">
                    <img data-index="${index}" src="${url}" width="100px" height="100px">
                    <div class="edit-remove_btn-box" data-index="${index}">
                      <span class="edit">編集</span>
                      <span class="remove">削除</span>
                    </div>
                  </div>`;
    return html;
  }



  
  function changeLabelFor(num) {
    $(".label").attr("for", `item_images_attributes_${num - 1}_image_url`)
  }





  let existCount = [1,2,3,4,5,6,7,8,9,10];

  lastIndex = $('.file:last').data('index');
  existCount.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  if($(".count-box").length >= 5){
    $(`.fa-camera`).hide();
  }

    //編集時画像を0枚にした時バリデーションかかる、その時の削除されるがrenderでプレビューが保持されていたのでdestroy-check入ってたらプレビュー消す
  $(function(){
    $('.hidden-destroy:checked').each(function(index){
      $(`div[data-index="${index}"].previews__field`).remove();
    });
  });



  $('.exhibit__image__upload').on('change', '.file__image', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);


    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {


      $('.previews').append(buildImg(targetIndex, blobUrl));
      $('.exhibit__image__upload').append(buildFileField(existCount[0]));
      existCount.shift();

      existCount.push(existCount[existCount.length - 1] + 1);

      changeLabelFor(existCount[0]);

      if($(".count-box").length >= 5){
        $(`.fa-camera`).hide();
      }


    }
  });

  $('.exhibit__image__upload').on('click', '.remove', function() {

    let targetIndex = $(this).parent().data('index');

    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    $(`div[data-index="${targetIndex}"]`).css("display", "none");
    $(`div[data-count="${targetIndex}"]`).removeClass("count-box"); 


    if ($('.file__image').length == 0) $('.field').append(buildFileField(existCount[0]));
    $(`#item_images_attributes_${targetIndex}_image_url`).remove();


    if($(".count-box").length << 4){
      $(`.fa-camera`).show();
    }
  });


  $('.exhibit__image__upload').on('click', '.edit', function() {
    const targetIndex = $(this).parent().data('index')
    $(`input[id="item_images_attributes_${targetIndex}_image_url"]`).on('click', function(e){
      e.stopPropagation();
    });

    $(`input[id="item_images_attributes_${targetIndex}_image_url"]`).trigger('click');

  });

});
