import "BasicNft"

/// Basic transaction for two accounts to authorize to transfer an NFT

transaction() {
    prepare(signer1: auth(LoadValue) &Account, signer2: auth(SaveValue) &Account) {
        let nft <- signer1.storage.load<@BasicNft.NFT>(from: /storage/BasicNftPath) 
            ?? panic("Could not load NFT from the first signer's storage")
        
        signer2.storage.save(<-nft, to: /storage/BasicNftPath)
    }

    execute {
        log("NFT transferred")
    }
}

/// Flow CLI Command for this to work:
/// flow transactions build cadence/transactions/basic_transfer.cdc --proposer emulator-account --payer emulator-account --authorizer emulator-account --authorizer test-account --filter payload --save tx1
/// flow transactions sign tx1 --signer test-account --filter payload --save tx2
/// flow transactions sign tx2 --signer emulator-account --filter payload --save tx3
/// flow transactions send-signed tx3