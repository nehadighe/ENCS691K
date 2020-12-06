import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import actions from "./actions/index"
import mutations from "./mutations/index"
// import mockItems from "./mockItems"
// import mockBids from "./mockBids"


Vue.use(Vuex)

export const getDefaultState = () => {
    return {
        authMode: "signup",
        user: [],
        userItemAvailability: [],
        userItemBought: [],
        authUser: {},
        bids: [], // this is where the bids will be held
        items: [],
        detailItem: {}, // detailItem which will be used to render separate items
        savingStatus: "",
        currentRoute: "",
        typeOfAvailability: "Active" // this will be the type of selection in UserItem screen
    }
}

export default new Vuex.Store({
    strict: false,
    plugins: [createPersistedState()],
    state: getDefaultState(),
    actions: actions,
    mutations: mutations
});