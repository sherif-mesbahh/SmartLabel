import React, { createContext, useContext, useEffect, useState } from "react";

const favoriteContext = createContext(null);
const FAVORITE_KEY = "favorites";
const EMPTY_FAVORITES = {
  items: [],
  totalCount: 0,
};

function FavoriteProvider({ children }) {
  const getItemsFromLocalStorage = () => {
    const storedFavorites = localStorage.getItem(FAVORITE_KEY);
    return storedFavorites ? JSON.parse(storedFavorites) : EMPTY_FAVORITES;
  };

  const initFavorites = getItemsFromLocalStorage();
  const [favoriteItems, setFavoriteItems] = useState(initFavorites.items);
  const [totalCount, setTotalCount] = useState(initFavorites.totalCount);

  const toggleFavorite = (food) => {
    const existingItem = favoriteItems.find((item) => item.food.id === food.id);

    if (existingItem) {
      DeleteFavorite(food);
    } else {
      setFavoriteItems([...favoriteItems, { food, isFavorite: true }]);
    }
  };
  const DeleteFavorite = (food) => {
    const updatedFavorites = favoriteItems.filter(
      (item) => item.food.id !== food.id
    );
    setFavoriteItems(updatedFavorites);
  };

  useEffect(() => {
    setTotalCount(favoriteItems.length);
    localStorage.setItem(
      FAVORITE_KEY,
      JSON.stringify({
        items: favoriteItems,
        totalCount: favoriteItems.length,
      })
    );
  }, [favoriteItems]);

  const clearFavorites = () => {
    localStorage.removeItem(FAVORITE_KEY);
    setFavoriteItems([]);
    setTotalCount(0);
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
