$(function() {
  // プルダウンメニューを選択することでイベントが発生
  $('select[name=sort_order]').change(function() {

    // 選択したoptionタグのvalue属性を取得する
    var this_value = $(this).val();
    // value属性の値により、ページ遷移先の分岐
    if (this_value == "price_asc") {
      html = "&sort=price+asc"
    } else if (this_value == "price_desc") {
      html = "&sort=price+desc"
    } else if (this_value == "created_at_asc") {
      html = "&sort=created_at+asc"
    } else if (this_value == "created_at_desc") {
      html = "&sort=created_at+desc"
    } else {
      html = ""
    };
    // 現在の表示ページ
    var current_html = window.location.href;
    // ソート機能の重複防止 
    if (location['href'].match(/&sort=*.+/) != null) {
      var remove = location['href'].match(/&sort=*.+/)[0]
      var current_html = current_html.replace(remove, '')
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

      var selected_option = location['href'].match(/&sort=*.+/)[0].replace('&sort=', '');

      if(selected_option == "price+asc") {
        var sort = 1
        
      } else if (selected_option == "price+desc") {
        var sort = 2
      } else if (selected_option == "created_at+asc") {
        var sort = 3
      } else if (selected_option == "created_at+desc") {
        var sort = 4
      }

      console.log(sort);

      var add_selected = $('select[name=sort_order]').children()[sort]
      $(add_selected).attr('selected', true)
    }
  });
});
