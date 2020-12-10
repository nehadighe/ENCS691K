import Api from '@/services/Api'

export default {
    // publish should be changed to post
    makeBid(bid) {
        // console.log('line 7 - API call: ', bid)
        return Api().post('/bids/register', bid)
    },
    getBidsByItemId(id) {
        return Api().get(`/bids/getBidsByItemId/${id}`)
    }
}