import { applyMiddleware, createStore } from 'redux';
import { createBrowserHistory } from 'history';
import { composeWithDevTools } from 'redux-devtools-extension';
import { routerMiddleware } from 'connected-react-router';
import ReduxThunk from 'redux-thunk';
import rootReducer from './root_reducer';

export const history = createBrowserHistory();

const middlewares = [routerMiddleware(history), ReduxThunk];

export default function configureStore(preloadedState) {
  const store = createStore(
    rootReducer(history),
    preloadedState,
    composeWithDevTools(applyMiddleware(...middlewares))
  );

  return store;
}
