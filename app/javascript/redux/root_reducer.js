import { combineReducers } from 'redux';
import { connectRouter } from 'connected-react-router';
import notificationReducer from './notifications';
import feedManagerReducer from './feed_manager';

export default history =>
  combineReducers({
    router: connectRouter(history),
    notifications: notificationReducer,
    feedManager: feedManagerReducer,
    isSignedIn: (state = {}) => state
  });
