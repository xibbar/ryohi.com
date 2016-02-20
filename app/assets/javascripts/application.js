// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require moment
//= require bootstrap-datetimepicker
//= require pickers
//= require moment/ja
//= require_tree .

$(function() {
  setModal();
})

function setModal() {

  //HTML読み込み時にモーダルウィンドウの位置をセンターに調整
  adjustCenter("div#modal div.inner");

  //ウィンドウリサイズ時にモーダルウィンドウの位置をセンターに調整
  $(window).resize(function() {
    adjustCenter("div#modal div.inner");
  });

  //モーダルウィンドウ内のcloseButtonクラスのリンクか背景をクリックしたら閉じる
  $("div#modal a.close, div#modal div.background").click(function() {
    displayModal(false);
  });

  //リンクがクリックされた時にAjaxでコンテンツを読み込む
  $("a.modal").click(function() {
    $("div#modal div.inner").load($(this).attr("href"), data="", onComplete);
    return false;
  });

  //コンテンツの読み込み完了時にモーダルウィンドウを開く
  function onComplete() {
    displayModal(true);
    $("div#modal div.inner a.close").click(function() {
      displayModal(false);
      return false;
    });
  };

}

//モーダルウィンドウを開く
function displayModal(sign) {
	if (sign) {
		$("div#modal").fadeIn(200);
	} else {
		$("div#modal").fadeOut(200);
	}
}

//ウィンドウの位置をセンターに調整
function adjustCenter(target) {
//  var margin_top = ($(window).height()-$(target).height())/2;
  var margin_left = ($(window).width()-$(target).width())/2;
//  $(target).css({top:margin_top+"px", left:margin_left+"px"});
  $(target).css({top:"90px", left:margin_left+"px"});
}
