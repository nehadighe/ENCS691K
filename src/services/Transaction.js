import Api from '@/services/Api'

export default {
    createTransaction(item) {
        console.log('line 5 - transaction API: ', item)
        return Api().post('/transactions/createTransaction', item)
    },
}