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
        // mockUser
        // authUser: {
        //     avatar: 'https://encs691k-assets.s3.amazonaws.com/avatar/Avatar-1.svg',
        //     username: 'edreinoso',
        //     email: 'edgardo_CJ@hotmail.com',
        //     firstName: 'Ed',
        //     lastName: 'Reinoso',
        //     authenticated: true,
        // },
        authUser: {},
        // mockBids
        // bids: mockBids, // this is where the bids will be held
        bids: [], // this is where the bids will be held
        items: [],
        // mockItems
        // mockItems: mockItems,
        detailItem: {}, // detailItem which will be used to render separate items
    }
}

export default new Vuex.Store({
    strict: false,
    plugins: [createPersistedState()],
    state: getDefaultState(),
    actions: actions,
    mutations: mutations
});