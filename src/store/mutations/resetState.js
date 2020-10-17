import { getDefaultState } from "../store"

export const resetAppState = (state) => {
    // console.log('store - mutations: resetState', state)
    Object.assign(state, getDefaultState())
}