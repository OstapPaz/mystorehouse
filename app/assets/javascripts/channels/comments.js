App.comments = App.cable.subscriptions.create("CommentsChannel", {
  collection: function() {
    return $('#comments');
  },

/*  generateHtml: function(comment) {
    let formComment = $('#comment').html()
  },*/

  connected: function() {
      return setTimeout((function(_this) {
          return function() {
              return _this.followCurrentProduct();
          };
      })(this), 1000);
  },
    disconnected: function() {},
    followCurrentProduct: function() {
        var productId;
        productId = this.collection().data('product-id');
        if (productId) {
            return this.perform('follow', {
                product_id: productId
            });
        } else {
            return this.perform('unfollow');
        }
    },
    received: function(data) {
        let comment = JSON.parse(data['foo']);
        //comment = generateHTML(comment);
        this.collection().append(comment);
    }
});