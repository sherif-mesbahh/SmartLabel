import React, { createContext, useContext, useEffect, useState } from "react";
import { addFav, deleteFav, getFav } from "../services/foodServices";

const favoriteContext = createContext(null);

function FavoriteProvider({ children }) {
  const [favoriteItems, setFavoriteItems] = useState([]);
  const [totalCount, setTotalCount] = useState(0);

  useEffect(() => {
    // Fetch initial favorites from API on mount
    getFav().then((response) => {
      const items = response.data.data || [];

      setFavoriteItems(items);
      setTotalCount(items.length);
    });
  }, []);

  const toggleFavorite = async (food) => {
    const existingItem = favoriteItems.find((item) => item.id === food.id);

    if (existingItem) {
      await DeleteFavorite(food);
    } else {
      await addFavorite(food);
    }
  };
  const addFavorite = async (food) => {
    try {
      await addFav(food.id);
      const response = await getFav();
      const items = response.data.data || [];

      setFavoriteItems(items);
      setTotalCount(items.length);
    } catch (error) {
      console.error("Failed to add favorite:", error);
    }
  };

  const DeleteFavorite = async (food) => {
    try {
      await deleteFav(food.id);
      const updated = favoriteItems.filter((item) => item.id !== food.id);
      setFavoriteItems(updated);
      setTotalCount(updated.length);
    } catch (error) {
      console.error("Failed to delete favorite:", error);
    }
  };

  const clearFavorites = () => {
    setFavoriteItems([]);
    setTotalCount(0);
    // Optional: implement a clear API call if needed
  };

  return (
    <favoriteContext.Provider
      value={{
        favorites: { items: favoriteItems, totalCount },
        toggleFavorite,
        clearFavorites,
        DeleteFavorite,
      }}
    >
      {children}
    </favoriteContext.Provider>
  );
}

export default FavoriteProvider;
export const useFavorites = () => useContext(favoriteContext);
