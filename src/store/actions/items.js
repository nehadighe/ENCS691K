import Api from "@/services/Api"

export const getAllItems = async (context) => {
    var result = await Api().get("/items/getAllItems");
    // console.log('line 5, actions- getAllItems', result);
    context.commit("getAllItems", result.data);
}

export const changeItemAvailability = (context, itemId) => {
    context.commit("changeItemAvailability", itemId)
}

export const showItem = (context, id) => {
    // console.log('line 14- showItem action', id)
    context.commit("showItem", id)
}

export const makeBid = (context, data) => {
    // console.log('items, action', userBid)
    context.commit("makeBid", data)
}

export const postItem = (context, item) => {
    // console.log('line 23- postItem actions', item)
    context.commit("postItem", item)
}