import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import actions from "./actions/index"
import mutations from "./mutations/index"

Vue.use(Vuex)

export const getDefaultState = () => {
    return {
        authMode: "signup",
        user: [],
        // mockUser
        authUser: {
            avatar: 'https://encs691k-assets.s3.amazonaws.com/avatar/Avatar-1.svg',
            username: 'edreinoso',
            email: 'edgardo_CJ@hotmail.com',
            firstName: 'Ed',
            lastName: 'Reinoso',
            authenticated: true,
        },
        // authUser: {},
        items: []
    }
}

export default new Vuex.Store({
    strict: false,
    plugins: [createPersistedState()],
    state: getDefaultState(),
    actions: actions,
    mutations: mutations
});