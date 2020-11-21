import Api from '@/services/Api'

export default {
    // publish should be changed to post
    post(item) {
        return Api().post('/items/addItem', item)
    },
    getItemById(id) {
        return Api().get(`/items/getItemById/${id}`)
    },
    // this should probably only for internal use only
    getAllitems() {
        return Api().get('/items/getAllItems')
    },
    reactivateItem(id) {
        console.log('line 16- Item Api', id)
        return Api().post(`/items/reactivateItem/${id}`)
    }
}