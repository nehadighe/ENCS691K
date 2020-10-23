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
    state.mockItems.map(item => {
        if (item.id == itemId) {
            item.availability = "Sold"
        }
    })
}