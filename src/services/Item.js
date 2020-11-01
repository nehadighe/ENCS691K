import Api from '@/services/Api'

export default {
    // publish should be changed to post
    post(item) {
        // console.log('line 6- item service api',item)
        // console.log('line 7 - API call: ', item)
        return Api().post('/items/addItem', item)
    },
    getItemById(id) {
        return Api().get(`/items/getItemById/${id}`)
    },
    // this should probably only for internal use only
    getAllitems() {
        return Api().get('/items/getAllItems')
    },
}