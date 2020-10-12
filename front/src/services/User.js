import Api from '@/services/Api'

export default {
    // publish should be changed to post
    post(user) {
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