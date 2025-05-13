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
export const getAllCat = async () => {
  const { data } = await axios.get(
    "http://smartlabel1.runasp.net/api/Categories"
  );

  return data;
};
export const getAllByCat = async (id) => {
  const { data } = await axios.get(
    "http://smartlabel1.runasp.net/api/Categories/" + id
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
    `http://smartlabel1.runasp.net/api/Products/${id}`
  );
  return data;
};

export const addCategory = async (Name, Image) => {
  const formData = new FormData();
  formData.append("Name", Name);
  formData.append("Image", Image);
  const { data } = await axios.post(
    "http://smartlabel1.runasp.net/api/Categories",
    formData,

    {
      headers: {
        "Content-Type": "multipart/form-data", // Set content type for FormData
      },
    }
  );
  return data;
};
export const addFood = async (
  Name,
  OLdPrice,
  Discount,
  Description,
  CategoryId,
  MainImage,
  ImagesFiles
) => {
  const formData = new FormData();
  formData.append("Name", Name);
  formData.append("OLdPrice", OLdPrice);
  formData.append("Discount", Discount);
  formData.append("Description", Description);
  formData.append("CatId", CategoryId);
  formData.append("MainImage", MainImage);
  formData.append("ImagesFiles", ImagesFiles);
  if (MainImage) {
    formData.append("MainImage", MainImage);
  }

  ImagesFiles.forEach((file) => {
    if (file) {
      formData.append("ImagesFiles", file);
    }
  });
  const { data } = await axios.post(
    "http://smartlabel1.runasp.net/api/Products",
    formData,

    {
      headers: {
        "Content-Type": "multipart/form-data", // Set content type for FormData
      },
    }
  );
  return data;
};
export const updateCategory = async (Id, Name, Image) => {
  const formData = new FormData();
  formData.append("Id", Id);
  formData.append("Name", Name);
  formData.append("Image", Image);
  const { data } = await axios.put(
    `http://smartlabel1.runasp.net/api/Categories`,
    formData,

    {
      headers: {
        "Content-Type": "multipart/form-data", // Set content type for FormData
      },
    }
  );
  return data;
};
export const updateFood = async (
  Id,
  Name,
  OldPrice,
  Discount,
  Description,
  CatId,
  MainImage,
  ImagesFiles,
  RemovedImageIds
) => {
  const formData = new FormData();
  formData.append("Id", Id);
  formData.append("Name", Name);
  formData.append("OldPrice", OldPrice);
  formData.append("Discount", Discount);
  formData.append("Description", Description);
  formData.append("CatId", CatId);

  if (MainImage) {
    formData.append("MainImage", MainImage);
  }

  ImagesFiles.forEach((file) => {
    if (file) {
      formData.append("ImagesFiles", file);
    }
  });

  RemovedImageIds.forEach((id) => {
    if (id) {
      formData.append("RemovedImageIds", id);
    }
  });

  const { data } = await axios.put(
    `http://smartlabel1.runasp.net/api/Products`,
    formData,
    {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    }
  );
  return data;
};

export const getBanners = async () => {
  const data = await axios.get("http://smartlabel1.runasp.net/api/Banners");
  return data;
};
export const addBanner = async (
  Title,
  Description,
  StartDate,
  EndDate,
  MainImage,
  ImagesFiles
) => {
  const formData = new FormData();
  formData.append("Title", Title);
  formData.append("Description", Description);
  formData.append("StartDate", StartDate);
  formData.append("EndDate", EndDate);
  formData.append("MainImage", MainImage);
  formData.append("ImagesFiles", ImagesFiles);
  if (MainImage) {
    formData.append("MainImage", MainImage);
  }

  ImagesFiles.forEach((file) => {
    if (file) {
      formData.append("ImagesFiles", file);
    }
  });

  const { data } = await axios.post(
    "http://smartlabel1.runasp.net/api/Banners",
    formData,

    {
      headers: {
        "Content-Type": "multipart/form-data", // Set content type for FormData
      },
    }
  );
  return data;
};
export const updateBanner = async (
  Id,
  Title,
  Description,
  StartDate,
  EndDate,
  MainImage,
  ImagesFiles,
  RemovedImageIds
) => {
  const formData = new FormData();
  formData.append("Id", Id);
  formData.append("Title", Title);
  formData.append("Description", Description);
  formData.append("StartDate", StartDate);
  formData.append("EndDate", EndDate);
  formData.append("MainImage", MainImage);
  formData.append("ImagesFiles", ImagesFiles);
  formData.append("RemovedImageIds", RemovedImageIds);
  if (MainImage) {
    formData.append("MainImage", MainImage);
  }

  ImagesFiles.forEach((file) => {
    if (file) {
      formData.append("ImagesFiles", file);
    }
  });

  RemovedImageIds.forEach((id) => {
    if (id) {
      formData.append("RemovedImageIds", id);
    }
  });

  const { data } = await axios.put(
    "http://smartlabel1.runasp.net/api/Banners",
    formData,

    {
      headers: {
        "Content-Type": "multipart/form-data", // Set content type for FormData
      },
    }
  );
  return data;
};
export const DeleteBannerId = async (id) => {
  const { data } = await axios.delete(
    `http://smartlabel1.runasp.net/api/Banners/${id}`
  );
  return data;
};
export const getBannerById = async (id) => {
  const data = await axios.get(
    `http://smartlabel1.runasp.net/api/Banners/${id}`
  );
  return data;
};
export const getFav = async () => {
  const data = await axios.get(
    "http://smartlabel1.runasp.net/api/me/favorites",
    { skipGlobalLoading: true }
  );
  return data;
};
export const addFav = async (id) => {
  const data = await axios.post(
    "http://smartlabel1.runasp.net/api/me/favorites/" + id,
    null,
    {
      skipGlobalLoading: true,
    }
  );
  return data;
};
export const deleteFav = async (id) => {
  const data = await axios.delete(
    "http://smartlabel1.runasp.net/api/me/favorites/" + id,
    { skipGlobalLoading: true }
  );
  return data;
};

export const deleteCategory = async (id) => {
  const data = axios.delete(
    `http://smartlabel1.runasp.net/api/Categories/${id}`
  );
  return data;
};

export const getPaginatedProducts = async (pageNumber, pageSize) => {
  const { data } = await axios.get(
    `http://smartlabel1.runasp.net/api/Products/paginated?PageNumber=${pageNumber}&PageSize=${pageSize}`
  );
  return data;
};
