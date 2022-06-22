const SSSToken = artifacts.require("SSSToken");

contract("SSSToken", (accounts) => {
  let sssTokenInstance;

  beforeEach(async () => {
    sssTokenInstance = await SSSToken.deployed();
  });

  it("user should not be able to mint tokens", async () => {
    const user = accounts[1];
    try {
      await sssTokenInstance.mint(user, (100 * 10 ** 18).toString(), {
        from: user,
      });
    } catch (error) {}
    const expectedBalance = 0 * 10 ** 18;
    const actualBalance = await sssTokenInstance.balanceOf(user);
    assert.equal(actualBalance, expectedBalance);
  });

  it("should not mint more than 10000 tokens", async () => {
    const admin = accounts[0];
    try {
      await sssTokenInstance.mint(admin, (10000 * 10 ** 18).toString());
    } catch (error) {}
    const expectedSupply = (100 * 10 ** 18).toString();
    const actualSupply = await sssTokenInstance.totalSupply();
    assert.equal(Number(actualSupply), Number(expectedSupply));
  });

  it("only admin should be able to mint tokens", async () => {
    const admin = accounts[0];
    await sssTokenInstance.mint(admin, (500 * 10 ** 18).toString());
    const expectedBalance = 600 * 10 ** 18;
    const actualBalance = await sssTokenInstance.balanceOf(admin);
    assert.equal(actualBalance, expectedBalance);
  });

  it("user should present in the list if balance is not zero", async () => {
    const admin = accounts[0];
    try {
      await sssTokenInstance.transferToken(
        admin,
        user1,
        (100 * 10 ** 18).toString()
      );
    } catch (error) {}

    const existed = await sssTokenInstance.checkExist(admin);
    assert.equal(existed, true);
  });

  it("user should not present in the list if balance is zero", async () => {
    const admin = accounts[0];
    const user1 = accounts[1];
    const user2 = accounts[2];
    await sssTokenInstance.transferToken(
      admin,
      user1,
      (100 * 10 ** 18).toString()
    );
    await sssTokenInstance.transferToken(
      user1,
      user2,
      (100 * 10 ** 18).toString()
    );
    const existed = await sssTokenInstance.checkExist(user1);

    assert.equal(existed, false);
  });
});
