export const authMode = (state, authModeAction) => {
    // console.log('store - mutation: authModeAction', authModeAction)
    state.authMode = authModeAction
}

export const userLookUp = (state, userInfo) => {
    // console.log('line 7 store - mutations: userLogin', userInfo)
    // not even going into this function
    state.user.map((item) => {
        // console.log('line 9- username in mutations', item.username, index)
        if (item.username == userInfo.username) { // this is going to the user name
            state.authUser = item // setting the authUser as the 
        }
    })
}

export const userSignUp = (state, userInfo) => {
    // console.log('line 17 store - mutations: userSignUp', userInfo)
    // console.log('line 18 store - mutations: userSignUp', state.user, state.authUser)
    state.user.push(userInfo) // push code to the user array
    state.authUser = userInfo // setting up the authUser after the 
}

export const userLogOut = (state) => {
    state.authUser = {}
}