document.addEventListener('turbolinks:load', function () {
  function buildCategoryForm(categories) {
    let options = "";
    if(categories[0].ancestry.indexOf("/" , 0) == -1){
      relation = "child";
    }else{
      relation = "grand_child"
    }
    categories.forEach(function (category) { 
      options += `
                  <option value="${category.id}">${category.name}</option>
                 `;
    });
    const html = `
                  <br class = "${relation}"> 
                  <select required="required" class="select-category ${relation}" id="parent-category" name="item[category_${relation}]">
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

  function selectNoValue(categories) {
    if(categories.initial == "parent"){
      $('.child').remove();
      $('.grandchild').remove();
    } else if(categories.initial == "child"){
      $('.grandchild').remove();
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
      if(categories.length != 0){
        existForm(categories);
        const html = buildCategoryForm(categories);
        $(".select-category:last").after(html);
      }
      selectNoValue(categories)
    })
    .fail(function () {
      alert('error');
    })
  });
});
