import { combineReducers } from 'redux';
import { connectRouter } from 'connected-react-router';
import notificationReducer from './notifications';
import feedManagerReducer from './feed_manager';
import entryListReducer from './entry_list';

export default history =>
  combineReducers({
    router: connectRouter(history),
    notifications: notificationReducer,
    feedManager: feedManagerReducer,
    entryList: entryListReducer,
    isSignedIn: (state = {}) => state
  });
