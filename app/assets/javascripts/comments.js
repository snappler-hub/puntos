// --------------- WIDGET CLASS --------------
$.CommentsWidget = function (element) { 
  this.element = (element instanceof $) ? element : $(element);

  this.init();
};

$.CommentsWidget.prototype = {

  // Inicialización de opciones y eventos
  init: function() {
    this.url = (this.element.data('path'));
    
    return this;
  },  
  
  launch: function() {
    var that = this;
    $.ajax({
      url: this.url,
      data: {
        limit: this.limit
      }
    })
    .done(function( data ) {
      that.element.html(data);
    });
  }
};

$.CommentsWidget.DefaultOptions = {
  limit: 1
};


// ------------ PAGE CHANGE --------------
// Activo el widget para los divs que encuentre
$(document).on('page:change', function () {
  $('.comments_widget').each(function(key, item) {
    var widget = new $.CommentsWidget(item);
    widget.launch();
  });
  
});
