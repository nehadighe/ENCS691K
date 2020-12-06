import Api from "@/services/Api"

export const getItemsByUsername = async (context, username) => {
    var result = await Api().get(`/items/getItemByUsername/${username}`);
    // console.log('line 5 - user.js user action getItemsByUsername');
    context.commit("getItemsByUsername", result.data)
}

export const getTransactionByUsername = async (context, username) => {
    var result = await Api().get(`/transactions/getTransactionsByUsername/${username}`);
    context.commit("getTransactionByUsername", result.data)
}

export const changeUserItemAvailability = (context, availabilityChange) => {
    // console.log('line 10- user actions,', availabilityChange)
    context.commit("changeUserItemAvailability", availabilityChange)
}