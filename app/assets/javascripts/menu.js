var NavBar = function (navLinks, window, menu) {
  this.navLinks = navLinks
  this.window = window
  this.menu = menu
}

NavBar.prototype.addClass = function () {
  this.navLinks.addClass("js").before('<div id="menu">&#9776;</div>');
}

NavBar.prototype.tog = function () {
  var that = this
  $('#menu').on('click', function () {
    that.navLinks.toggle();
  })
}

NavBar.prototype.removeA = function () {
  var that = this;
  this.window.resize(function () {
    this.window.innerWidth > 768 ? that.navLinks.removeAttr("style") : null
  })
}
