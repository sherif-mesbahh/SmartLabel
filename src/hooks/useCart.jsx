import React, {
  createContext,
  useContext,
  useEffect,
  useState,
  useCallback,
} from "react";
import { addFav, deleteFav, getFav } from "../services/foodServices";

const favoriteContext = createContext(null);

function FavoriteProvider({ children }) {
  const [favoriteItems, setFavoriteItems] = useState([]);
  const totalCount = favoriteItems.length;

  const fetchFavorites = useCallback(async () => {
    try {
      const response = await getFav();
      const items = response.data.data || [];
      setFavoriteItems(items);
    } catch (error) {
      console.error("Failed to fetch favorites:", error);
    }
  }, []);

  useEffect(() => {
    fetchFavorites();
  }, [fetchFavorites]);

  const addFavorite = useCallback(
    async (food) => {
      try {
        setFavoriteItems((prev) => [...prev, food]);
        await addFav(food.id);
        fetchFavorites().catch(console.error);
      } catch (error) {
        setFavoriteItems((prev) => prev.filter((item) => item.id !== food.id));
        console.error("Failed to add favorite:", error);
      }
    },
    [fetchFavorites]
  );

  const DeleteFavorite = useCallback(
    async (food) => {
      try {
        // Optimistic update
        setFavoriteItems((prev) => prev.filter((item) => item.id !== food.id));
        await deleteFav(food.id);
        // Confirm with server (but don't wait for response to update UI)
        fetchFavorites().catch(console.error);
      } catch (error) {
        // Rollback on error
        fetchFavorites();
        console.error("Failed to delete favorite:", error);
      }
    },
    [fetchFavorites]
  );

  const toggleFavorite = useCallback(
    async (food) => {
      const isFavorite = favoriteItems.some((item) => item.id === food.id);
      if (isFavorite) {
        await DeleteFavorite(food);
      } else {
        await addFavorite(food);
      }
    },
    [favoriteItems, DeleteFavorite, addFavorite]
  );

  return (
    <favoriteContext.Provider
      value={{
        favorites: { items: favoriteItems, totalCount },
        toggleFavorite,
        DeleteFavorite,
      }}
    >
      {children}
    </favoriteContext.Provider>
  );
}

export default FavoriteProvider;
export const useFavorites = () => useContext(favoriteContext);
