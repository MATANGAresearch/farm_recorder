import React, { createContext, useContext, useState, useEffect } from 'react';
import axios from 'axios';
import { postApiAuthLogin } from './authentication/authentication';

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
    
    // Keycloak preferred_username is the user identifier
    const username = decoded.preferred_username || decoded.sub || 'user';
    
    // Extract roles from realm_access
    const roles = decoded.realm_access?.roles || [];
    const role = roles.includes('ADMIN') ? 'ADMIN' : 'FARM_WORKER';
    
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

  useEffect(() => {
    if (token) {
      const parsedUser = parseJwt(token);
      if (parsedUser) {
        setUser(parsedUser);
      } else {
        logout();
      }
    }
    setIsLoading(false);
  }, [token]);

  const login = async (username: string, password: string) => {
    try {
      const response = await postApiAuthLogin({ username, password });
      const data = response.data as { access_token?: string };
      
      if (data && data.access_token) {
        const accessToken = data.access_token;
        const parsedUser = parseJwt(accessToken);
        if (parsedUser) {
          localStorage.setItem('token', accessToken);
          setToken(accessToken);
          setUser(parsedUser);
          // Set authorization header globally immediately
          axios.defaults.headers.common['Authorization'] = `Bearer ${accessToken}`;
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
