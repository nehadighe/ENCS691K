import Api from "@/services/Api"

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

export const loadUserToState = async (context) => {
    // console.log('line 20, action')
    var result = await Api().get("/users");
    // console.log('line 5, actions- getAllItems', result);
    context.commit("loadUserToState", result.data);
}