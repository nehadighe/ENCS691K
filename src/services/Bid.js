import Api from '@/services/Api'

export default {
    // publish should be changed to post
    makeBid(bid) {
        // console.log('line 6- item service api',item)
        // console.log('line 7 - API call: ', bid)
        return Api().post('/bids/register', bid)
    },
}