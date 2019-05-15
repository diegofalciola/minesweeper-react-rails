import axios from 'axios';

const http = axios.create({
  baseURL: `http://localhost:4000/`,
});

http.interceptors.request.use(function(config) {
  const token = localStorage.getItem('token');
  config.headers.Authorization = token;
  return config;
});

export default http;

