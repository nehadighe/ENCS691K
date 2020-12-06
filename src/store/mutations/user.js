export const getItemsByUsername = async (state, data) => {
    // console.log('line 2- user mutations',data)
    // console.log('line 3 - user.js user mutations getItemsByUsername', data);
    state.userItemAvailability = []
    state.authUser.Items = data

    var activeAndpendingItems = [] // active && pending
    var soldItems = [] // sold
    state.authUser.Items.map(item => {
        if (item.availability === 'Active' || item.availability === 'Pending') activeAndpendingItems.push(item)
        else soldItems.push(item)
    })
    if (state.typeOfAvailability === 'Active') state.userItemAvailability = activeAndpendingItems
    else state.userItemAvailability = soldItems
}

export const getTransactionByUsername = async (state, data) => {
    state.userItemBought = []
    // console.log('line 20 - getTransactionByUsername - user mutation', data)
    state.userItemBought = data
}

export const changeUserItemAvailability = (state, availabilityStatus) => {
    // trying to resuse one variable instead of using multiple variables
    state.userItemAvailability = [] // flushing the userItemAvailability array from the state
    var activeAndpendingItems = [] // active && pending
    var soldItems = [] // sold
    state.authUser.Items.map(item => {
        if (item.availability === 'Active' || item.availability === 'Pending') activeAndpendingItems.push(item)
        else soldItems.push(item)
    })
    if (availabilityStatus == 'Active') state.userItemAvailability = activeAndpendingItems
    else state.userItemAvailability = soldItems
    state.typeOfAvailability = availabilityStatus
}