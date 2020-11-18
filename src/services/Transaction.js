import Api from '@/services/Api'

export default {
    createTransaction(item) {
        return Api().post('/transactions/createTransaction', item)
    },
}