var modal = (function(){
    var 
    method = {},
    $overlay = $('<div id="overlay"></div>');
    $modal = $('<div id="modal"></div>');
    $content = $('<div id="content"></div>');
    $close = $('<a id="close" href="#">close</a>');

    // Append the HTML

    // Center the modal in the viewport
    method.center = function () {
    var top, left;

    top = Math.max($(window).height() - $modal.outerHeight(), 0) / 2;
    left = Math.max($(window).width() - $modal.outerWidth(), 0) / 2;

    $modal.css({
        top:top + $(window).scrollTop(), 
        left:left + $(window).scrollLeft()
    });
    };

    // Open the modal
    method.open = function (settings) {
    $content.empty().append(settings.content);

    $modal.css({
        width: settings.width || 'auto', 
        height: settings.height || 'auto'
    })

    method.center();

    $(window).bind('resize.modal', method.center);

    $modal.show();
    $overlay.show();
    };

    // Close the modal
    method.close = function () {
    $modal.hide();
    $overlay.hide();
    $content.empty();
    $(window).unbind('resize.modal');
    };

    return method;
}());



$(function () {
    $('.nav-animate').click(function (e) {
        e.preventDefault()
        console.log('click')
        
        modal.open({content: "Yolo"})
    })
})