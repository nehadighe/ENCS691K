import Api from '@/services/Api'

export default {
    post(item) {
        return Api().post('/images/add', item)
    },
    delete(id) {
        return Api().delete(`/images/delete/${id}`)
    },
    
    // come back to this
    // getImagesByItemId() {
    //     return Api().get(`/images/${itemId}`)
    // },
}