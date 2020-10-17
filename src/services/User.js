import Api from '@/services/Api'

export default {
    // publish should be changed to post
    post(user) {
        console.log('is this going through: ', user)
        return Api().post('/users/register', user)
    },
    getUserById(id) {
        return Api().get(`/users/${id}`)
    },
    // this should probably only for internal use only
    getAllUsers() {
        return Api().get('/users')
    },
}