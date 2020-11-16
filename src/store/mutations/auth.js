export const authMode = (state, authModeAction) => {
    // console.log('store - mutation: authModeAction', authModeAction)
    state.authMode = authModeAction
}

export const userLookUp = (state, userInfo) => {
    // console.log('line 7 store - mutations: userLogin', userInfo)
    // not even going into this function
    // console.log('line 9- username in mutations', state.user)
    state.user.map((item) => {
        // console.log('line 11- username in mutations', item.username)
        if (item.username == userInfo.username) { // this is going to the user name
            state.authUser = item // setting the authUser as the item
            state.authUser.authenticated = true // setting the authUser as the item
        }
    })
    // console.log('line 15- auth mutations', state.authUser)
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

export const loadUserToState = (state, userData) => {
    // console.log('line 32, state: mutation- ', userData)
    state.user = userData
}