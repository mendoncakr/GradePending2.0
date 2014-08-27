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
//= require jquery_ujs
//= require jquery-ui
//= require underscore
//= require_tree



$(function(){
	$('.about').hide();
	$('.map_and_search').hide();

	$('#explore').hover(function(){
		$(this).addClass('animated pulse');
	})

	$("#explore").on("click", function(){
		$('.map_and_search').fadeIn('slow');
		initialize()
		$(this).hide();
	})

	$('#nav_links li').hover(function(){
		$(this).addClass('animated pulse');
	})
})