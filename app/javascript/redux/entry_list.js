import { ENTRIES_FETCHED, CLEAR_ENTRIES, ENTRY_FETCHED, ENTRY_UPDATED } from './action_types';
import { getRequest, postRequest } from '../shared/fetch';

// Action creators
export function entriesFetched(payload) {
  return {
    type: ENTRIES_FETCHED,
    entries: payload.entries,
    total: payload.total || 0,
    totalUnread: payload.total_unread,
    totalStarred: payload.total_starred
  };
}

export function entryFetched(newIndex, payload) {
  return {
    type: ENTRY_FETCHED,
    entry: payload.entry,
    newIndex,
    totalUnread: payload.total_unread,
    totalStarred: payload.total_starred
  };
}

export function entryUpdated(payload) {
  return {
    type: ENTRY_UPDATED,
    entry: payload.entry,
    totalUnread: payload.total_unread,
    totalStarred: payload.total_starred
  };
}

export const clearEntries = () => async dispatch => {
  dispatch({ type: CLEAR_ENTRIES });
};

export const fetchEntries = (filter, page = 0, search = '') => async dispatch => {
  const esc = encodeURIComponent;
  const params = { page, search };
  const query = Object.keys(params)
    .map(k => `${esc(k)}=${esc(params[k])}`)
    .join('&');

  getRequest(`/entries/${filter}.json?${query}`, data => {
    dispatch(entriesFetched(data));
  });
};

export const fetchEntry = (newIndex, entryId) => async dispatch => {
  getRequest(`/entries/${entryId}.json`, data => {
    dispatch(entryFetched(newIndex, data));
    const element = document.getElementById(`entry-${entryId}`);
    element.scrollIntoView();
  });
};

export const updateEntry = (entryId, params) => async dispatch => {
  postRequest(`/entries/${entryId}.json`, 'PATCH', params, data => {
    dispatch(entryUpdated(data));
  });
};

// Initial state
const initialState = {
  entries: [],
  viewedEntry: {},
  selectedIndex: -1,
  total: 0,
  totalUnread: 0,
  totalStarred: 0
};

const entryListReducer = (state = initialState, action) => {
  switch (action.type) {
    case ENTRIES_FETCHED:
      return {
        ...state,
        ...{
          entries: action.entries,
          total: action.total,
          totalUnread: action.totalUnread,
          totalStarred: action.totalStarred
        }
      };
    case CLEAR_ENTRIES:
      return { ...state, ...{ entries: [], viewedEntry: {}, selectedIndex: -1, total: 0 } };
    case ENTRY_FETCHED:
      return {
        ...state,
        ...{
          viewedEntry: action.entry,
          selectedIndex: action.newIndex,
          totalUnread: action.totalUnread,
          totalStarred: action.totalStarred
        }
      };
    case ENTRY_UPDATED:
      return {
        ...state,
        ...{
          viewedEntry: action.entry,
          totalUnread: action.totalUnread,
          totalStarred: action.totalStarred
        }
      };
    default:
      return state;
  }
};

export default entryListReducer;
