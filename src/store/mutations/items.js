import _ from "lodash";

export const getAllItems = async (state, data) => {
    console.log('line 2- mutations: getAllItems', data)
    // you need to order by the availability
    const sortedItems = _.orderBy(data, function (o) {
        return o.availability
    }, ['asc']);
    state.items = sortedItems
}

export const changeItemAvailability = (state, itemId) => {
    console.log('accessing this state')
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
    // console.log('mutations, bid', userBid)
    state.bids.push(userBid)
    state.mockItems.map(item => {
        if (item.id == userBid.itemId) {
            // is this going to work?
            item.currentNumberOfBidding++;
        }
    })
}