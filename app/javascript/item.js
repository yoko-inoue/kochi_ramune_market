window.addEventListener("load", function() {
  const passive_images = document.querySelectorAll(".passive_image");
  //cssセレクタの '.passive_image'を取得して定数passive_imagesに代入
  passive_images.forEach(function(item, index){
    item.onmouseover = function(){
      document.getElementById("bigimg").src = this.src;
      // イベントが発生してる要素（this）のsrcを、id=bidimgの要素のsrcに代入（上書き？）してる
    }
  });
});