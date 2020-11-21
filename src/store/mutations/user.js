export const getItemsByUsername = async (state, data) => {
    state.userItemAvailability = []
    state.authUser.Items = []
    state.authUser.Items.push(data)
    // default would be available, not sold
    state.authUser.Items.map(item => {
        if (item.availability === "Active") {
            state.userItemAvailability.push(item)
        }
    })
}

export const changeUserItemAvailability = (state, availabilityStatus) => {
    state.userItemAvailability = []
    console.log('line 16- user mutations', availabilityStatus)
    state.authUser.Items.map(item => {
        if (item.availability === availabilityStatus) {
            
            state.userItemAvailability.push(item)
        }
    })
}