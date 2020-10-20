export const getAllItems = async (state, data) => {
    console.log('line 2- mutations: getAllItems', data)
    state.items = data
}