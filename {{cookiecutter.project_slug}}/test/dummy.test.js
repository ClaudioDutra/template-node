const { dummy } = require("../src/dummy");

describe("Validating the dummy", () => {
  test('should return "This is a dummy"', () => {
    expect(dummy()).toBe("This is a dummy");
  });
});
