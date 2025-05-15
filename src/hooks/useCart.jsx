import React, {
  createContext,
  useContext,
  useEffect,
  useState,
  useCallback,
} from "react";
import { addFav, deleteFav, getFav } from "../services/foodServices";
import { toast } from "react-toastify";
import { useNavigate } from "react-router-dom";

const favoriteContext = createContext(null);

function FavoriteProvider({ children }) {
  const [favoriteItems, setFavoriteItems] = useState([]);
  const navigate = useNavigate();
  const [isLoading, setIsLoading] = useState(false);
  const totalCount = favoriteItems.length;

  const fetchFavorites = useCallback(async () => {
    try {
      setIsLoading(true);
      const response = await getFav();
      const items = response.data.data || [];
      setFavoriteItems(items);
    } catch (error) {
      console.error("Failed to fetch favorites:", error);
      toast.error(" you are not logged in");
      navigate("/login");
    } finally {
      setIsLoading(false);
    }
  }, []);

  // Update a specific favorite item
  const updateFavoriteItem = useCallback((updatedFood) => {
    setFavoriteItems(prev => 
      prev.map(item => 
        item.id === updatedFood.id ? { ...item, ...updatedFood } : item
      )
    );
  }, []);

  useEffect(() => {
    fetchFavorites();
  }, [fetchFavorites]);

  const addFavorite = useCallback(
    async (food) => {
      try {
        setIsLoading(true);
        // Optimistic update
        setFavoriteItems((prev) => [...prev, food]);
        
        // API call
        await addFav(food.id);
        
        // Refresh from server to ensure consistency
        await fetchFavorites();
        
        toast.success("Added to favorites");
      } catch (error) {
        // Rollback on error
        setFavoriteItems((prev) => prev.filter((item) => item.id !== food.id));
        console.error("Failed to add favorite:", error);
        toast.error("you are not logged in");
        navigate("/login");
      } finally {
        setIsLoading(false);
      }
    },
    [fetchFavorites]
  );

  const DeleteFavorite = useCallback(
    async (food) => {
      try {
        setIsLoading(true);
        // Optimistic update
        setFavoriteItems((prev) => prev.filter((item) => item.id !== food.id));
        
        // API call
        await deleteFav(food.id);
        
        // Refresh from server to ensure consistency
        await fetchFavorites();
        
        toast.success("Removed from favorites");
      } catch (error) {
        // Rollback on error
        await fetchFavorites();
        console.error("Failed to delete favorite:", error);
        
      } finally {
        setIsLoading(false);
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
        favorites: { items: favoriteItems, totalCount, isLoading },
        toggleFavorite,
        DeleteFavorite,
        refreshFavorites: fetchFavorites,
        updateFavoriteItem,
      }}
    >
      {children}
    </favoriteContext.Provider>
  );
}

export default FavoriteProvider;
export const useFavorites = () => useContext(favoriteContext);
