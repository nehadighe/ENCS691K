export const authMode = (context, authModeValue) => {
    // console.log('store - action authMode: ', authModeValue)
    context.commit("authMode", authModeValue)
}

export const userLogIn = (context, userInfo) => {
    // console.log('store - action userLogin: ', userInfo)
    context.commit("userLogIn", userInfo)
}

export const userSignUp = (context, userInfo) => {
    // console.log('store - action userSignUp: ', userInfo)
    context.commit("userSignUp", userInfo)
}