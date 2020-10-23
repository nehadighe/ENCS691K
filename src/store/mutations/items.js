export const getAllItems = async (state, data) => {
    console.log('line 2- mutations: getAllItems', data)
    state.items = data
}

export const changeItemAvailability = (state, itemId) => {
    state.mockItems.map(item => {
        if (item.id == itemId) {
            item.availability = "Sold"
        }
    })
}