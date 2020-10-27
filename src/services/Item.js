import Api from '@/services/Api'

export default {
    // publish should be changed to post
    post(item) {
        // console.log('line 6- item service api',item)
        // console.log('is this going through: ', item)
        return Api().post('/item/addItem', item)
    },
    getItemById(id) {
        return Api().get(`/items/getItemById/${id}`)
    },
    // this should probably only for internal use only
    getAllitems() {
        return Api().get('/items/getAllItems')
    },
}