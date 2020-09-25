export const authMode = (state, authModeAction) => {
    // console.log('store - mutation: authModeAction', authModeAction)
    state.authMode = authModeAction
}

export const userLogIn = (state, userInfo) => {
    console.log('store - mutations: userLogin', userInfo)
    state.user = userInfo
}

export const userSignUp = (state, userInfo) => {
    console.log('store - mutations: userSignUp', userInfo)
    state.user = userInfo
}