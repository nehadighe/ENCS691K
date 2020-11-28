import Api from '@/services/Api'

export default {
    // publish should be changed to post
    post(item) {
        return Api().post('/items/postItem', item)
    },
    editItem(item) {
        return Api().put('/items/editItem/', item)
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
    },
    storeImages(image) {
        console.log('line 25 - item.js storeImages', image)
        return Api().post('/images/store', image)
    }
}