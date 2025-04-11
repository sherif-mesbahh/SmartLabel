import axios from "axios";

export const SetLoadingInterceptors = ({ hideLoading, showLoading }) => {
  axios.interceptors.request.use(
    (req) => {
      if (!(req.data instanceof FormData)) showLoading();

      return req;
    },
    (error) => {
      hideLoading();
      return Promise.reject(error);
    }
  );

  axios.interceptors.response.use(
    (response) => {
      hideLoading();
      return response;
    },
    (error) => {
      hideLoading();
      return Promise.reject(error);
    }
  );
};
export default SetLoadingInterceptors;
