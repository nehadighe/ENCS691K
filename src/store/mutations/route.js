export const setCurrentRoute = (state, data) => {
    state.currentRoute = data
}

export const pushItemIdToVisitedArr = (state, itemId) => {
    state.visited.push(itemId)
    // console.log('line 7 route mutation - ', state.visited)
}

export const changeUserHasVisitedItem = (state, data) => {
    state.userHasVisitedItem = data
    console.log('line 12 route mutation - ', state.userHasVisitedItem)
}