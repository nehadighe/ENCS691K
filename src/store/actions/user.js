import Api from "@/services/Api"

export const getItemsByUsername = async (context, username) => {
    var result = await Api().get(`/items/getItemByUsername/${username}`);
    context.commit("getItemsByUsername", result.data)
}
