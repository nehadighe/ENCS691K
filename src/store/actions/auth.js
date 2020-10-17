export const authMode = (context, authModeValue) => {
    context.commit("authMode", authModeValue)
}

export const userLookUp = (context, userInfo) => {
    context.commit("userLookUp", userInfo)
}

export const userSignUp = (context, userInfo) => {
    context.commit("userSignUp", userInfo)
}

export const userLogOut = (context) => {
    context.commit("userLogOut")
}