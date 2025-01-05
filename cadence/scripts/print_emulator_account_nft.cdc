import "ExampleNft"

access(all)
fun main(address: Address): [UInt64] {
    // Get the public account object for account emulator-account
    let nftOwner: &Account = getAccount(address)

    // Find the public Receiver capability for their Collection and borrow it
    let receiverRef: &ExampleNft.Collection = nftOwner.capabilities.borrow<&ExampleNft.Collection>(ExampleNft.CollectionPublicPath)
        ?? panic("Could not borrow a reference to the NFT Collection"
                .concat("from the public path ")
                .concat(ExampleNft.CollectionPublicPath.toString())
                .concat(". Make sure the Collection has been published."))
    // Log the NFTs that they own as an array of IDs
    log("Emulator account NFTs")
    return receiverRef.getIds()
}