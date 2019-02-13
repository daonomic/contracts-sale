const util = require('util');
const BN = web3.utils.BN;

const Sale = artifacts.require("SimplePriceBasedSale.sol");
const Token = artifacts.require("ERC20Mintable.sol");

const tests = require("@daonomic/tests-common");
const expectThrow = tests.expectThrow;
const randomAddress = tests.randomAddress;
const verifyBalanceChange = tests.verifyBalanceChange;
const increaseTime = tests.increaseTime;

const decimals = new BN("1000000000000000000");

contract('PriceBasedSale', accounts => {
  let token;
  let paymentToken;
  let sale;

  function assertEq(v1, v2) {
    assert(new BN(v1).eq(new BN(v2)), "v1=" + v1.toString() + " v2=" + v2.toString());
  }

  function tokens(amount) {
    return decimals.mul(new BN(amount));
  }

  beforeEach(async () => {
    token = await Token.new();
    paymentToken = await Token.new();
    sale = await Sale.new(token.address);

    await token.addMinter(sale.address);
    await sale.addOperator(accounts[9]);
  });

  it("should sell 10 tokens for 1 ETH", async () => {
    var tx = await sale.sendTransaction({value: tokens(1)});
    console.log(tx.receipt.gasUsed);
    assertEq(await token.balanceOf(accounts[0]), tokens(10))
  });

  it("should sell 1000 tokens for 1 BTC", async () => {
    var tx = await sale.onReceive(accounts[1], "0x0000000000000000000000000000000000000002", "100000000", "0xffffff", {from: accounts[9]});
    console.log(tx.receipt.gasUsed);
    assertEq(await token.balanceOf(accounts[1]), tokens(1000))
  });
});