import React, { createContext, useContext, useState, useEffect } from 'react';
import axios from 'axios';

interface User {
  username: string;
  role: 'ADMIN' | 'FARM_WORKER';
}

interface AuthContextType {
  token: string | null;
  user: User | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  login: (username: string, password: string) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

const parseJwt = (token: string): User | null => {
  try {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(
      window.atob(base64)
        .split('')
        .map((c) => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
        .join('')
    );
    const decoded = JSON.parse(jsonPayload);
    
    const username = decoded.email || decoded.user_id || 'user';
    const role = decoded.role === 'ADMIN' ? 'ADMIN' : 'FARM_WORKER';
    
    return { username, role };
  } catch (error) {
    console.error('Error parsing token:', error);
    return null;
  }
};

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [token, setToken] = useState<string | null>(localStorage.getItem('token'));
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  const FIREBASE_API_KEY = (import.meta as any).env?.VITE_FIREBASE_API_KEY || 'AIzaSyPlaceholderKey12345';

  useEffect(() => {
    if (token) {
      const parsedUser = parseJwt(token);
      if (parsedUser) {
        setUser(parsedUser);
        axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      } else {
        logout();
      }
    }
    setIsLoading(false);
  }, [token]);

  const login = async (email: string, password: string) => {
    try {
      const url = `https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${FIREBASE_API_KEY}`;
      const response = await axios.post(url, {
        email,
        password,
        returnSecureToken: true
      });

      const data = response.data;
      if (data && data.idToken) {
        const idToken = data.idToken;
        const parsedUser = parseJwt(idToken);
        if (parsedUser) {
          localStorage.setItem('token', idToken);
          setToken(idToken);
          setUser(parsedUser);
          axios.defaults.headers.common['Authorization'] = `Bearer ${idToken}`;
        } else {
          throw new Error('Invalid authentication token');
        }
      } else {
        throw new Error('Invalid credentials');
      }
    } catch (error) {
      logout();
      throw error;
    }
  };

  const logout = () => {
    localStorage.removeItem('token');
    setToken(null);
    setUser(null);
    delete axios.defaults.headers.common['Authorization'];
  };

  const isAuthenticated = !!token;

  return (
    <AuthContext.Provider value={{ token, user, isAuthenticated, isLoading, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
