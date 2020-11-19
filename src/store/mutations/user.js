export const getItemsByUsername = async (state, data) => {
    console.log('line 2- user mutation', data)
    state.authUser.Items = []
    state.authUser.Items.push(data)
    // state.authUser.Items = data
    // add the Items to the users array
    // state.users.map(item => {
    //     if(item.username === data.username) {
    //         item.Items = data
    //     }
    // })
}