describe("retro", function() {

  var builder;

  beforeEach(function() {
    builder = postItBuilder();
  });

  it("should create a post it with id", function() {
    var jpostIt = {text: 'some text'};
    var postIt = builder.create(jpostIt);

    expect(postIt.id).toBeDefined();
    expect(postIt.text).toEqual('some text');
  });

  it("should create two post its with different ids", function() {
    var id1 = builder.create({}).id;
    var id2 = builder.create({}).id;

    expect(id1).not.toEqual(id2);
  });

});
