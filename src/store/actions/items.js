import Api from "@/services/Api"

export const getAllItems = async (context) => {
    var result = await Api().get("/items/getAllItems");
    // console.log('line 5, actions- getAllItems', result);
    context.commit("getAllItems", result.data);
}

// this is after creating an item
export const getItemById = async (context, id) => {
    var result = await Api().get(`/items/getItemById/${id}`);
    context.commit("getItemById", result.data)
}

// this is for view item
export const showItem = (context, id) => {
    context.commit("showItem", id)
}

export const changeItemAvailability = (context, itemId) => {
    context.commit("changeItemAvailability", itemId)
}

export const makeBid = (context, data) => {
    // console.log('items, action', userBid)
    context.commit("makeBid", data)
}

export const deleteItemById = async (context, item) => {
    context.commit("deleteItemById", item)
}

export const postItem = (context, item) => {
    context.commit("postItem", item)
}

export const savingItem = (context, saving) => {
    // console.log('store(action) - savingItem', saving)
    context.commit("savingItem", saving)
}
