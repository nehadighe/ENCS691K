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

export const showItem = (state, data) => {
    // state.mockItems.map(item => {
    state.items.map(item => {
        if (item.id == data.id) {
            state.detailItem = item
        }
    })
}

// bid is going to be the item: name, image, time
// biddingAmount
export const makeBid = (state, data) => {
    console.log('31- mutations, bid', data)
    state.items.map(item => {
        if (item.id == data.itemId) {
            // is this going to work?
            item.Bids.push(item);
            item.currentNumberOfBidding++;
        }
    })
}

export const postItem = (state, item) => {
    // console.log('line 50 - postItem', item)
    state.items.push(item);
}