export const setCurrentRoute = (context, data) => {
    context.commit("setCurrentRoute", data)
}

export const pushItemIdToVisitedArr = (context, itemId) => {
    context.commit("pushItemIdToVisitedArr", itemId)
}

export const changeUserHasVisitedItem = (context, data) => {
    context.commit("changeUserHasVisitedItem", data)
}