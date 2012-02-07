describe("Wall", function() {
  it("should add post it with given text", function() {
    loadFixtures("wall.html");
    $("#new_post_it_text").text("build takes too long");
    expect($("#post_it_1")).toHaveText("build takes too long");

  });

});
