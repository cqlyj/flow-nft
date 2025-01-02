import Test

access(all) let account = Test.createAccount()

access(all) fun testContract() {
    let err = Test.deployContract(
        name: "BasicNft",
        path: "../contracts/BasicNft.cdc",
        arguments: [],
    )

    Test.expect(err, Test.beNil())
}