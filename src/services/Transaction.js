import Api from '@/services/Api'

export default {
    createTransaction(item) {
        console.log('creating transaction')
        return Api().post('/transactions/createTransaction', item)
    },
}