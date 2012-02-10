var uiAdapter = function() {

  var update = function(postIt, sender) {
    var uiPostIt = getPostIt(postIt);

    uiPostIt.children('.content').html(postIt.text);
    uiPostIt.show();
    $("#board").append(uiPostIt);
    uiPostIt.makeDraggable();

    return uiPostIt;
  };

  var getFromPage = function(postIt) {
    return $('#' + postIt.id);
  };

  var create = function(postIt) {
    var element = $("#base_post_it").clone()
        .attr("id", postIt.id)
        .removeClass("hidden")
        .addClass("new")
        .addClass(postIt.group);
    return element;
  };

  var makeDraggable = function(){
    this.draggable({
      containment: "#board", 
      handle: ".header",
    });
  };

  var getPostIt = function(postIt) {
    var retrievedPostIt = getFromPage(postIt);
    if (retrievedPostIt.length === 0) {
      retrievedPostIt = create(postIt);
    }
    retrievedPostIt.makeDraggable = makeDraggable;
    return retrievedPostIt;
  };

  return {
    update: update
  };
};
