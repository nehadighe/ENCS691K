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
    console.log('line 17 - item mutations', state.items)
}

// this is after creating an item
export const getItemById = (state, item) => {
    state.detailItem = item // it's a lot faster to go in memory
}

// this is for view item
export const showItem = (state, id) => {
    console.log('line 26 - item mutations getItemById', id)
    state.items.map(item => {
        if (item.id == id) {
            state.detailItem = item
        }
    })
}

// bid is going to be the item: name, image, time
// biddingAmount
export const makeBid = (state, data) => {
    state.detailItem.Bids.push(data)
    state.detailItem.startBidTime = data.startBidTime
    state.detailItem.bidPrice = data.amount
    state.detailItem.currentNumberOfBidding++
}

export const deleteItemById = (state, item) => {
    state.items.splice(state.items.indexOf(item), 1);
    state.userItemAvailability.splice(state.userItemAvailability.indexOf(item), 1);
}

export const postItem = (state, item) => {
    state.items.push(item)
}

export const savingItem = (state, saving) => {
    // // console.log('store(mutations) - savingItem: ', saving)
    state.savingStatus = saving
}