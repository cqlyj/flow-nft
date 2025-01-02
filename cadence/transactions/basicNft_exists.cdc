import "BasicNft"

// This transaction checks if an NFT exists in the storage of the given account
// by trying to borrow from it. If the borrow succeeds (returns a non-nil value), the token exists!
transaction() {
    prepare(account: auth(BorrowValue) &Account) {
        if(account.storage.borrow<&BasicNft.NFT>(from: /storage/BasicNftPath) != nil) {
            log("NFT exists")
        } else {
            log("NFT does not exist")
        }
    }

    execute {}
}