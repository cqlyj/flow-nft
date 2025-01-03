access(all)
contract ExampleNft {

    // path constants
    access(all) let CollectionStoragePath: StoragePath
    access(all) let CollectionPublicPath: PublicPath
    access(all) let MinterStoragePath: StoragePath

    // id of NFTs
    access(all) var idCount: UInt64

    access(all) resource NFT  {
        // The unique ID that differentiates each NFT
        access(all) let id: UInt64

        init(initId: UInt64) {
            self.id = initId
        }
    }

    access(all) entitlement Withdraw

    // The definition of the Collection resource that holds the NFTs that a user owns
    access(all) resource Collection {
        // dictionary of NFT conforming tokens
        // NFT is a resource type with an `UInt64` ID field
        access(all) var ownedNFT: @{UInt64: NFT}

        init() {
           self.ownedNFT <- {}
        }

        // withdraw
        //
        // Function that removes an NFT from the collection
        // and moves it to the calling context


        // deposit
        //
        // Function that takes a NFT as an argument and
        // adds it to the collections dictionary

        // idExists checks to see if a NFT
        // with the given ID exists in the collection

        // getIDs returns an array of the IDs that are in the collection
        
    }

    init() {
        self.CollectionStoragePath = /storage/ExampleNftCollection
        self.CollectionPublicPath = /public/ExampleNftCollection
        self.MinterStoragePath = /storage/ExampleNftMinter
        self.idCount = 1
    }
}