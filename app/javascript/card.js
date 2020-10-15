document.addEventListener('turbolinks:load', function () {
  if (!$('#card_form')[0]) return false; //カード登録ページではないなら以降実行しない。

  Payjp.setPublicKey("pk_test_fdf25c52fd959a5486e20150");

  const regist_button = $("#regist_card"); //カード入力フォームの登録ボタン。

  regist_button.on("click", function (e) { //登録ボタンを押したとき（ここはsubmitではなくclickにしておく）。
    e.preventDefault();
    const card = {
      number: document.querySelector('input[name="card[number]"]').value,
      cvc: document.querySelector('input[name="card[cvc]"]').value,
      exp_month: document.querySelector('select[name="card[exp_month]"]').value,
      exp_year: document.querySelector('select[name="card[exp_year]"]').value
    };

    Payjp.createToken(card, (status, response) => { //cardをpayjpに送信して登録する。

      if (status === 200) { //成功した場合
        alert("カードを登録しました");
        // ↓hidden_fieldにcardのtokenを入れることでtokenがparamsに送られる。
        $("#card_token").append(
          `<input type="hidden" name="payjp_token" value=${response.id}>`
        );
        $("#card_number_form").removeAttr("name");
        $("#cvc_form").removeAttr("name");
        $("#exp_month_form").removeAttr("name");
        $("#exp_year_form").removeAttr("name");
        // ↓formのsubmitボタンを強制起動する（ページが遷移してコントローラが起動する）。
        $('#card_form')[0].submit();
      } else { //失敗した場合
        alert("カード情報が正しくありません。");
        regist_button.prop('disabled', false);
      }

    });
  }); //登録ボタンを押したときここまで。

});