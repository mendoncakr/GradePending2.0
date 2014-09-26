var NavBar = function (nav_links, window, menu) {
  this.nav_links = nav_links
  this.window = window
  this.menu = menu
}

NavBar.prototype.addClass = function () {
  this.nav_links.addClass("js").before('<div id="menu">&#9776;</div>');
}

NavBar.prototype.tog = function () {
  this.menu.click(function () {
    this.nav_links.toggle();
  })
}

NavBar.prototype.removeA = function () {
  this.window.resize(function () {
    this.window.innerWidth > 768 ? this.nav_links.removeAttr("style") : null
  })
}
