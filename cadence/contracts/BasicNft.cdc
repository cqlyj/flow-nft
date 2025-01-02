access(all)
contract BasicNft {

    // NFT resource
    access(all) resource NFT {
        // NFT ID
        access(all) let id: UInt64

        // NFT metadata (String mappings to store the metadata)
        access(all) var metadata: {String: String}

        init(initId: UInt64) {
            self.id = initId
            self.metadata = {}
        }
    }

    access(all) fun createNft(id: UInt64): @NFT {
        return <-create NFT(initId: id)
    }

    init() {
        self.account.storage.save(<-create NFT(initId: 1), to: /storage/BasicNftPath)
    }
}