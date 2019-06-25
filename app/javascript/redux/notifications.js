import { ADD_NOTIFICATION, REMOVE_NOTIFICATION } from './action_types';

// Action creators
export function addNotification(notification) {
  return {
    type: ADD_NOTIFICATION,
    notification
  };
}

export function removeNotification(notification) {
  return {
    type: REMOVE_NOTIFICATION,
    notification
  };
}

export const addNotificationWithTimer = notification => async dispatch => {
  dispatch(addNotification(notification));

  setTimeout(() => dispatch(removeNotification(notification)), 5000);
};

export const setNotificationsWithTimers = notifications => async dispatch => {
  notifications.forEach(notification => {
    setTimeout(() => dispatch(removeNotification(notification)), 5000);
  });
};

// Initial notification state
const initialState = {
  notifications: []
};

const notificationReducer = (state = initialState, action) => {
  switch (action.type) {
    case ADD_NOTIFICATION:
      return [...state, action.notification];
    case REMOVE_NOTIFICATION:
      return [
        ...state.filter(
          notification =>
            notification.type !== action.notification.type ||
            notification.message !== action.notification.message
        )
      ];
    default:
      return state;
  }
};

export default notificationReducer;
