import axios from 'axios'

export default () => {
    return axios.create({
        baseURL: 'https://elb.encs691k.edgardoreinoso.com:8081' // localhost endpoint
        // baseURL: 'http://encs691k-14042286.us-east-1.elb.amazonaws.com:8081' // localhost endpoint
        // baseURL: 'http://localhost:8081/' // localhost endpoint
    })
}