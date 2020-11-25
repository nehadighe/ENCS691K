import Api from '@/services/Api'

export default {
    // publish should be changed to post
    post(item) {
        return Api().post('/items/postItem', item)
    },
    edit(item) {
        return Api().post(`/items/editItem/${item}`, item)
    },
    getItemById(id) {
        return Api().get(`/items/getItemById/${id}`)
    },
    // this should probably only for internal use only
    getAllitems() {
        return Api().get('/items/getAllItems')
    },
    reactivateItem(id) {
        return Api().post(`/items/reactivateItem/${id}`)
    },
    deleteItemById(id) {
        return Api().delete(`/items/deleteItemById/${id}`)
    }
}