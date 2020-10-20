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
                    <option value="${relation}">選択してください</option>
                    ${options}
                  </select>
                 `;
                 return html;
  }
  // 並び替えの挙動
$(function() {
  // プルダウンメニューを選択することでイベントが発生
  $('select[name=sort_order]').change(function() {
    // 選択したoptionタグのvalue属性を取得する
    const sort_order = $(this).val();
    // value属性の値により、ページ遷移先の分岐

    switch (sort_order) {
      case 'price-asc': html = "&sort=price+asc"; break;
      case 'price-desc': html = "&sort=price+desc"; break;
      case 'created_at-asc': html = "&sort=created_at+asc"; break;
      case 'created_at-desc': html = "&sort=created_at+desc"; break;
      case 'likes-desc': html = "&sort=likes_count_desc"; break;
      default: html = "&sort=created_at+desc"; 
    }
    // 現在の表示ページ
    let current_html = window.location.href;
    // ソート機能の重複防止 
    if (location['href'].match(/&sort=*.+/) != null) {
      var remove = location['href'].match(/&sort=*.+/)[0]
      current_html = current_html.replace(remove, '')
    };
    // ページ遷移
    window.location.href = current_html + html
  });
  // ページ遷移後の挙動
  $(function () {
    if (location['href'].match(/&sort=*.+/) != null) {
      // option[selected: 'selected']を削除
      if ($('select option[selected=selected]')) {
        $('select option:first').prop('selected', false);
      }

      const selected_option = location['href'].match(/&sort=*.+/)[0].replace('&sort=', '');

      switch (selected_option) {
        case "price+asc": var sort = 1; break;
        case "price+desc": var sort = 2; break;
        case "created_at+asc": var sort = 3; break;
        case "created_at+desc": var sort = 4; break;
        case "likes_count_desc": var sort = 5; break;
        default: var sort = 0
      }
      const add_selected = $('select[name=sort_order]').children()[sort]
      $(add_selected).attr('selected', true)
    }
  });
});

  $(function () {
    $("#js_conditions_clear").on("click", function () {
        clearForm(this.form);
    });
  
    function clearForm (form) {
      $(form)
          .find("input, select, textarea")
          .not(":button, :submit, :reset, :hidden")
          .val("")
          .prop("checked", false)
          .prop("selected", false)
      ;
      $('select[name=sort_order]').children().first().attr('selected', true);
      $('#children_category_search').remove();
      $('#grandchildren_category_checkboxes').remove();
    }
  });

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
  
  $(".exhibit__select-wrap").on("change", ".select-category", function () { 
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
