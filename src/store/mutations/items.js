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

// this is after creating an item
export const getItemById = (state, item) => {
    state.detailItem = item // it's a lot faster to go in memory
    state.detailItem.visited = true
}

// this is for view item
export const showItem = (state, id) => {
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
    console.log('line 41 - item mutations', state.detailItem)
}

export const deleteItemById = (state, item) => {
    state.items.splice(state.items.indexOf(item), 1);
    state.userItemAvailability.splice(state.userItemAvailability.indexOf(item), 1);
}

export const postItem = (state, item) => {
    state.items.push(item)
}

export const savingItem = (state, saving) => {
    state.savingStatus = saving
}