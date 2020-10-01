document.addEventListener('turbolinks:load', function () {
  function buildCategoryForm(categories) {
    let options = "";
    if(categories[0].ancestry.indexOf("/" , 0) == -1){
      relation ="child";
    }else{
      relation = "grand_child"
    }
    console.log(relation);
    categories.forEach(function (category) { 
      options += `
                  <option value="${category.id}">${category.name}</option>
                 `;
    });
    const html = `
                  <br class = "${relation}"> 
                  <select required="required" class="select-category ${relation}" id="parent-category" name="item[category_id]">
                    <option value="${relation}">---</option>
                    ${options}
                  </select>
                 `;
                 return html;
  }

  function existForm(categories){
    if(categories[0].ancestry.indexOf("/" , 0) == -1){
      $('.child').remove();
      $('.grand_child').remove();
    }else{
      $('.grand_child').remove();
    }
  }
  
  $(".sell__about__right__wrap-box.parent").on("change", ".select-category", function () { 
    const category_id = $(this).val();
    $.ajax({
      url: '/api/categories', 
      type: "GET",
      data: {
        category_id: category_id
      },
      dataType: 'json',
    }).done(function (categories) {
      console.log("success")
      console.log(categories)
      if(categories.length != 0){
        existForm(categories);
        const html = buildCategoryForm(categories);
        console.log(html);
        $(".select-category:last").after(html);
      }
    })
    .fail(function () {
      alert('error');
    })
  });
});
