import _ from "lodash";

export const getAllItems = async (state, data) => {
    console.log('line 2- mutations: getAllItems', data)
    // you need to order by the availability
    const sortedItems = _.orderBy(data, function (o) {
        return o.availability
    }, ['asc']);
    state.items = sortedItems
}

// changin the currentNumberOfBidding in the item
export const addingBid = (state, itemId) => {
    // 
    state.mockItems.map(item => {
        if (item.id == itemId) {
            // is this going to work?
            item.currentNumberOfBidding++;
        }
    })
}

export const changeItemAvailability = (state, itemId) => {
    state.mockItems.map(item => {
        if (item.id == itemId) {
            item.availability = "Sold"
        }
    })
    state.mockItems = state.mockItems.filter(item => {
        return item.id !== itemId
    })
}

export const showItem = (state, itemId) => {
    state.mockItems.map(item => {
        if (item.id == itemId) {
            state.detailItem = item
        }
    })
}

// bid is going to be the item: name, image, time
// biddingAmount
export const makeBid = (state, userBid) => {
    state.bid.push(userBid)
}