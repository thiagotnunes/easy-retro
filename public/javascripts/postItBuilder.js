var postItBuilder = function() {

  var create = function(postIt) {
    postIt.id = generateId();
    return postIt;
  };

  var generateId = function() {
    return Date.now() + '_' + Math.floor(Math.random()*50);
  };

  return {
    create: create
  };
};
