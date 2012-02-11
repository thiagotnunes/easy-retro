describe("ui adapter", function() {

  var adapter; 
  var sender;

  beforeEach(function() {
    sender = { send: jasmine.createSpy() };
    adapter = uiAdapter(sender);
    loadFixtures("board.html");
  });

  it("should create a post it", function() {
    var postIt = {id: 123, text: 'some text'};

    var element = adapter.update(postIt);
    expect(element).toHaveId('123');
    expect(element.children('.content')).toHaveHtml('some text');
    expect($('#123')).toExist();
    expect($('[id=123]').length).toEqual(1);
    expect(element).toHaveClass('ui-draggable');
  });

  it("should update a post it", function() {
    var postIt = {id: 123, text: 'some text'};
    var element = adapter.update(postIt);

    postIt.text = 'other text';
    element = adapter.update(postIt);

    expect(element).toHaveId('123');
    expect(element.children('.content')).toHaveHtml('other text');
    expect($('[id=123]').length).toEqual(1);
    expect(element).toHaveClass('ui-draggable');
  });

//  it("should send movements", function() {
//    //given I create a post it with id 123
//    var element = adapter.update({id: 123});
//    
//    //when I move the post it to position left 200 top 300
//    element.offset({left: 200, top: 300});
//    element.stop();
//    //then a message should be sent with this position
//    expect(sender.send).toHaveBeenCalledWith({id: 123, left:200, top: 300});
//  });
});
