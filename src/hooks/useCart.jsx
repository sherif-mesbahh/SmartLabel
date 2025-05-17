import React, {
  createContext,
  useContext,
  useEffect,
  useState,
  useCallback,
} from "react";
import { toast } from "react-toastify";
import { useNavigate } from "react-router-dom";

const cartContext = createContext(null);

function CartProvider({ children }) {
  const [cartItems, setCartItems] = useState([]);
  const navigate = useNavigate();
  const [isLoading, setIsLoading] = useState(false);
  const totalCount = cartItems.length;

  // Calculate total price
  const totalPrice = cartItems.reduce((total, item) => {
    return total + (item.price * item.quantity);
  }, 0);

  const addToCart = useCallback(
    async (product) => {
      try {
        setIsLoading(true);
        setCartItems((prev) => {
          const existingItem = prev.find((item) => item.id === product.id);
          if (existingItem) {
            return prev.map((item) =>
              item.id === product.id
                ? { ...item, quantity: item.quantity + 1 }
                : item
            );
          }
          return [...prev, { ...product, quantity: 1 }];
        });
        toast.success("Added to cart");
      } catch (error) {
        console.error("Failed to add to cart:", error);
        toast.error("Failed to add to cart");
      } finally {
        setIsLoading(false);
      }
    },
    []
  );

  const removeFromCart = useCallback(
    async (productId) => {
      try {
        setIsLoading(true);
        setCartItems((prev) => prev.filter((item) => item.id !== productId));
        toast.success("Removed from cart");
      } catch (error) {
        console.error("Failed to remove from cart:", error);
        toast.error("Failed to remove from cart");
      } finally {
        setIsLoading(false);
      }
    },
    []
  );

  const updateQuantity = useCallback(
    async (productId, quantity) => {
      try {
        setIsLoading(true);
        if (quantity < 1) {
          await removeFromCart(productId);
          return;
        }
        setCartItems((prev) =>
          prev.map((item) =>
            item.id === productId ? { ...item, quantity } : item
          )
        );
      } catch (error) {
        console.error("Failed to update quantity:", error);
        toast.error("Failed to update quantity");
      } finally {
        setIsLoading(false);
      }
    },
    [removeFromCart]
  );

  const clearCart = useCallback(() => {
    setCartItems([]);
    toast.success("Cart cleared");
  }, []);

  return (
    <cartContext.Provider
      value={{
        cart: {
          items: cartItems,
          totalCount,
          totalPrice,
          isLoading,
        },
        addToCart,
        removeFromCart,
        updateQuantity,
        clearCart,
      }}
    >
      {children}
    </cartContext.Provider>
  );
}

export default CartProvider;
export const useCart = () => useContext(cartContext);
