import Api from '@/services/Api'

export default {
    storeImages(image) {
        // console.log('line 5 - item.js storeImages', image)
        return Api().post('/images/store', image)
    },
    deleteImage(imageId) {
        // console.log('line 9 - item.js deleteImage')
        return Api().delete(`/images/delete/${imageId}`)
    },
    
    // come back to this
    // getImagesByItemId() {
    //     return Api().get(`/images/${itemId}`)
    // },
}