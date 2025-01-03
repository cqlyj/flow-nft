import Test

access(all) let account = Test.createAccount()

access(all) fun testContract() {
    let err = Test.deployContract(
        name: "ExampleNft",
        path: "../contracts/ExampleNft.cdc",
        arguments: [],
    )

    Test.expect(err, Test.beNil())
}