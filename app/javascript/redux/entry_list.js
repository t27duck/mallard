import { ENTRIES_FETCHED, CLEAR_ENTRIES, ENTRY_FETCHED } from './action_types';
import { getRequest } from '../shared/fetch';

// Action creators
export function entriesFetched(entries) {
  return {
    type: ENTRIES_FETCHED,
    entries
  };
}

export function entryFetched(newIndex, entry) {
  return {
    type: ENTRY_FETCHED,
    entry,
    newIndex
  };
}

export const clearEntries = () => async dispatch => {
  dispatch({ type: CLEAR_ENTRIES });
};

export const fetchEntries = filter => async dispatch => {
  getRequest(`/entries/${filter}.json`, entries => {
    dispatch(entriesFetched(entries.entries));
  });
};

export const fetchEntry = (newIndex, entryId) => async dispatch => {
  getRequest(`/entries/${entryId}.json`, entry => {
    dispatch(entryFetched(newIndex, entry));
    const element = document.getElementById(`entry-${entryId}`);
    element.scrollIntoView();
  });
};

// Initial state
const initialState = {
  entries: [],
  viewedEntry: {},
  selectedIndex: -1,
  total: 0
};

const entryListReducer = (state = initialState, action) => {
  switch (action.type) {
    case ENTRIES_FETCHED:
      return { ...state, ...{ entries: action.entries } };
    case CLEAR_ENTRIES:
      return { ...state, ...{ entries: [], viewedEntry: {}, selectedIndex: -1, total: 0 } };
    case ENTRY_FETCHED:
      return { ...state, ...{ viewedEntry: action.entry, selectedIndex: action.newIndex } };
    default:
      return state;
  }
};

export default entryListReducer;
