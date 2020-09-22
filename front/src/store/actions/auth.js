export const authMode = (context, authModeValue) => {
    // console.log('store - action authMode: ', authModeValue)
    context.commit("authMode", authModeValue)
}