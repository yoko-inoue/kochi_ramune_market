document.addEventListener('turbolinks:load', function () {
  function buildCategoryForm(categories) { // 子孫カテゴリのフォームを組み立てる
    let options = "";
    categories.forEach(function (category) { // カテゴリを一つずつ渡してoptionタグを一つずつ組み立てていく。
      options += `
                  <option value="${category.id}">${category.name}</option>
                 `;
    });
    const html = `
                  <br> 
                  <select required="required" class="select-category" id="parent-category" name="item[category_id]">
                    <option value="">---</option>
                    ${options}
                  </select>
                 `;
    return html;
  }
  
  $(".sell__about__right__wrap-box.parent").on("change", ".select-category", function () { //カテゴリが選択された時
    const category_id = $(this).val();
    console.log("選択されたカテゴリのID:", category_id);
    $.ajax({
      url: '/api/categories', 
      type: "GET",
      data: {
        category_id: category_id
      },
      dataType: 'json',
    }).done(function (categories) {
      console.log("success")
      if(categories.length != 0){
      if(categories != "---"){
      console.log(categories)
      const html = buildCategoryForm(categories);
      console.log(html);
      $(".select-category:last").after(html);}}
    })
    .fail(function () {
      alert('error');
    })
  });
});