import { FEEDS_FETCHED } from './action_types';
import { getRequest, postRequest } from '../shared/fetch';
import { addNotificationWithTimer } from './notifications';

// Action creators
export function feedsFetched(feeds) {
  return {
    type: FEEDS_FETCHED,
    feeds
  };
}

export const fetchFeeds = () => async dispatch => {
  getRequest(`/feeds/list.json`, feeds => {
    dispatch(feedsFetched(feeds));
  });
};

export const fetchFeed = feedId => async dispatch => {
  getRequest(`/feeds/${feedId}/fetch.json`, data => {
    dispatch(addNotificationWithTimer(data.alert));
    dispatch(feedsFetched(data.feeds));
  });
};

export const updateFeed = (feedId, params) => async dispatch => {
  postRequest(`/feeds/${feedId}.json`, 'PATCH', params, data => {
    dispatch(addNotificationWithTimer(data.alert));
    dispatch(feedsFetched(data.feeds));
  });
};

export const addFeed = params => async dispatch => {
  postRequest(`/feeds.json`, 'POST', params, data => {
    dispatch(addNotificationWithTimer(data.alert));
    if (data.alert.type === 'notice') {
      dispatch(fetchFeeds());
    }
  });
};

export const deleteFeed = feedId => async dispatch => {
  postRequest(`/feeds/${feedId}.json`, 'DELETE', {}, data => {
    dispatch(addNotificationWithTimer(data.alert));
    dispatch(fetchFeeds());
  });
};

// Initial state
const initialState = {
  feeds: []
};

const feedManagerReducer = (state = initialState, action) => {
  switch (action.type) {
    case FEEDS_FETCHED:
      return { ...state, ...{ feeds: action.feeds } };
    default:
      return state;
  }
};

export default feedManagerReducer;
