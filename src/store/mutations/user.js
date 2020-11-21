export const getItemsByUsername = async (state, data) => {
    // console.log('line 2- user mutations',data)
    state.userItemAvailability = []
    // state.authUser.Items = []
    state.authUser.Items = data
    state.authUser.Items.map(item => {
        if (item.availability === "Active") {
            state.userItemAvailability.push(item)
        }
    })
}

export const getTransactionByUsername = async (state, data) => {
    state.userItemBought = []
    state.userItemBought = data
}

export const changeUserItemAvailability = (state, availabilityStatus) => {
    state.userItemAvailability = []
    // console.log('line 16- user mutations', availabilityStatus)
    state.authUser.Items.map(item => {
        if (item.availability === availabilityStatus) {

            state.userItemAvailability.push(item)
        }
    })
}