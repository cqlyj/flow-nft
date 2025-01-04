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
        access(all) fun withdraw (withdrawId: UInt64): @NFT {
            let token: @ExampleNft.NFT <- self.ownedNFT.remove(key: withdrawId) 
                ?? panic("NFT not found in collection with id="
                    .concat(withdrawId.toString())
                    .concat("Verify that the NFT exists in the collection before withdrawing."))
            return <-token       
        }


        // deposit
        //
        // Function that takes a NFT as an argument and
        // adds it to the collections dictionary
        access(all) fun deposit(token: @NFT) {
            // add the new token to the dictionary with a force assignment
            // if there is already a value at that key, it will fail and revert
            self.ownedNFT[token.id] <-! token
        }

        // idExists checks to see if a NFT
        // with the given ID exists in the collection
        access(all) view fun idExists (id: UInt64): Bool {
            return self.ownedNFT[id] != nil
        }

        // getIDs returns an array of the IDs that are in the collection
        access(all) view fun getIds (): [UInt64] {
            return self.ownedNFT.keys
        }
    }

    // creates a new empty Collection resource and returns it
    access(all) fun createEmptyCollection(): @Collection {
        return <-create Collection()
    }

    // mintNFT
    //
    // Function that mints a new NFT with a new ID
    // and returns it to the caller

    access(all) fun mintNft(): @NFT {
        var newNft: @ExampleNft.NFT <- create NFT(initId: self.idCount) 
        // change the id so that each ID is unique
        self.idCount = self.idCount + 1
        return <-newNft
    }

    init() {
        self.CollectionStoragePath = /storage/ExampleNftCollection
        self.CollectionPublicPath = /public/ExampleNftCollection
        self.MinterStoragePath = /storage/ExampleNftMinter
        self.idCount = 1

        // store an empty NFT Collection in account storage
        self.account.storage.save( <- self.createEmptyCollection(), to: self.CollectionStoragePath)

        // publish a capability to the Collection in storage
        let cap =  self.account.capabilities.storage.issue<&Collection>(
            self.CollectionStoragePath
        )
        self.account.capabilities.publish(cap, at: self.CollectionPublicPath)
    }
}