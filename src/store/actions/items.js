import Api from "@/services/Api"

export const getAllItems = async (context) => {
    var result = await Api().get("/items/getAllItems");
    // console.log('line 5, actions- getAllItems', result);
    context.commit("getAllItems", result.data);
}

export const addingBid = (context, itemId) => {
    context.commit("addingBid", itemId)
}

export const changeItemAvailability = (context, itemId) => {
    context.commit("changeItemAvailability", itemId)
}

export const showItem = (context, itemId) => {
    context.commit("showItem", itemId)
}

export const makeBid = (context, userBid) => {
    context.commit("makeBid", userBid)
}