import axios from "axios";
export const getAll = async () => {
  const { data } = await axios.get(
    "http://smartlabel1.runasp.net/api/Products"
  );

  return data;
};

export const search = async (searchTerm) => {
  const { data } = await axios.get(
    `http://smartlabel1.runasp.net/api/Products/paginated?Search=${searchTerm}`
  );
  return data;
};
export const getAllTags = async () => {
  const { data } = await axios.get(
    "http://smartlabel1.runasp.net/api/Categories"
  );

  return data;
};
export const getAllByTags = async (id) => {
  const { data } = await axios.get(
    "http://newsmartlabel.runasp.net/api/product/category/" + id
  );

  return data;
};
export const getById = async (foodid) => {
  const { data } = await axios.get(
    "http://smartlabel1.runasp.net/api/Products/" + foodid
  );
  return data;
};

export const DeleteFoodId = async (id) => {
  const { data } = await axios.delete(
    `http://newsmartlabel.runasp.net/api/categories/${id}`
  );
  return data;
};

export const addCategory = async (Name, Image) => {
  const formData = new FormData();
  formData.append("Name", Name);
  formData.append("Image", Image);
  const { data } = await axios.post(
    "http://newsmartlabel.runasp.net/api/categories",
    formData,

    {
      headers: {
        Authorization: `Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMzMzNjMWEzLTNjYWUtNDcwMC04ZTk1LWVhZjk3ZWIwNTFlZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJ5eSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6Inl5QGdtYWlsLmNvbSIsImp0aSI6IjFmYWQ5MDg2LWY5MmMtNGQxNS05NTVkLTRhNmQ4YjM1MjE0NCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkFkbWluIiwiaXNBZG1pbiI6IlRydWUiLCJleHAiOjE3MzYwMjk3MDAsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDQyMjUiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjU1NTUifQ.0Q-6GZg6eDCwrt4MzmPLwuPO6bQNMlf-Fu0pCfubX9E`, // Attach the token in the Authorization header
        "Content-Type": "multipart/form-data", // Set content type for FormData
      },
    }
  );
  return data;
};
export const addFood = async (
  name,
  imageFile,
  price,
  discount = 0,
  expirationDate = "",
  categoryId = 1
) => {
  const formData = new FormData();
  formData.append("Name", name);
  formData.append("Image", imageFile);
  formData.append("Price", price);
  formData.append("Discount", discount);
  formData.append("ExpirationDate", expirationDate);
  formData.append("CategoryId", categoryId);
  const { data } = await axios.post(
    "http://newsmartlabel.runasp.net/api/product",
    formData,

    {
      headers: {
        Authorization: `Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMzMzNjMWEzLTNjYWUtNDcwMC04ZTk1LWVhZjk3ZWIwNTFlZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJ5eSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6Inl5QGdtYWlsLmNvbSIsImp0aSI6IjFmYWQ5MDg2LWY5MmMtNGQxNS05NTVkLTRhNmQ4YjM1MjE0NCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkFkbWluIiwiaXNBZG1pbiI6IlRydWUiLCJleHAiOjE3MzYwMjk3MDAsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDQyMjUiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjU1NTUifQ.0Q-6GZg6eDCwrt4MzmPLwuPO6bQNMlf-Fu0pCfubX9E`, // Attach the token in the Authorization header
        "Content-Type": "multipart/form-data", // Set content type for FormData
      },
    }
  );
  return data;
};
export const updateCategory = async (Name, Image, id) => {
  const formData = new FormData();
  formData.append("Name", Name);
  formData.append("Image", Image);
  const { data } = await axios.put(
    `http://newsmartlabel.runasp.net/api/categories/${id}`,
    formData,

    {
      headers: {
        Authorization: `Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMzMzNjMWEzLTNjYWUtNDcwMC04ZTk1LWVhZjk3ZWIwNTFlZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJ5eSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6Inl5QGdtYWlsLmNvbSIsImp0aSI6IjFmYWQ5MDg2LWY5MmMtNGQxNS05NTVkLTRhNmQ4YjM1MjE0NCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkFkbWluIiwiaXNBZG1pbiI6IlRydWUiLCJleHAiOjE3MzYwMjk3MDAsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDQyMjUiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjU1NTUifQ.0Q-6GZg6eDCwrt4MzmPLwuPO6bQNMlf-Fu0pCfubX9E`, // Attach the token in the Authorization header
        "Content-Type": "multipart/form-data", // Set content type for FormData
      },
    }
  );
  return data;
};
export const updateFood = async (
  name,
  imageFile,
  price,
  discount = 0,
  expirationDate = "",
  categoryId = 1,
  id
) => {
  const formData = new FormData();
  formData.append("Name", name);
  formData.append("Image", imageFile);
  formData.append("Price", price);
  formData.append("Discount", discount);
  formData.append("ExpirationDate", expirationDate);
  formData.append("CategoryId", categoryId);
  const { data } = await axios.put(
    `http://newsmartlabel.runasp.net/api/product/${id}`,
    formData,

    {
      headers: {
        Authorization: `Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMzMzNjMWEzLTNjYWUtNDcwMC04ZTk1LWVhZjk3ZWIwNTFlZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJ5eSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6Inl5QGdtYWlsLmNvbSIsImp0aSI6IjFmYWQ5MDg2LWY5MmMtNGQxNS05NTVkLTRhNmQ4YjM1MjE0NCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkFkbWluIiwiaXNBZG1pbiI6IlRydWUiLCJleHAiOjE3MzYwMjk3MDAsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDQyMjUiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjU1NTUifQ.0Q-6GZg6eDCwrt4MzmPLwuPO6bQNMlf-Fu0pCfubX9E`, // Attach the token in the Authorization header
        "Content-Type": "multipart/form-data", // Set content type for FormData
      },
    }
  );
  return data;
};
export const getBanners = async () => {
  const data = await axios.get("http://smartlabel1.runasp.net/api/Banners");
  return data;
};

export const getBannerById = async (id) => {
  const data = await axios.get(
    `http://smartlabel1.runasp.net/api/Banners/${id}`
  );
  return data;
};
