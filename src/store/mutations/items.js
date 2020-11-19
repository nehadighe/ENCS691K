export const getAllItems = async (state, data) => {
    state.items = data
}

export const changeItemAvailability = (state, itemId) => {
    // console.log('accessing this state')
    // state.mockItems.map(item => {
    state.items.map(item => {
        if (item.id == itemId) {
            item.availability = "Sold"
        }
    })
    // state.mockItems = state.mockItems.filter(item => {
    state.items = state.items.filter(item => {
        return item.id !== itemId
    })
}

export const showItem = (state, id) => {
    // console.log('line 20 data-', id)
    state.items.map(item => {
        if (item.id == id) {
            state.detailItem = item
        }
    })
}

// bid is going to be the item: name, image, time
// biddingAmount
export const makeBid = (state, data) => {
    state.items.map(item => {
        if (item.id == data.itemId) {
            item.Bids.push(data)
            item.startBidTime = data.startBidTime
            item.bidPrice = data.amount
            item.currentNumberOfBidding++
        }
    })
}