import React from 'react';
import PropTypes from 'prop-types';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import Alert from './Alert';
import Navigation from './Navigation';
import EntryList from './EntryList';
import Feeds from './Feeds';

const App = props => {
  const { flashAlerts } = props;

  return (
    <>
      <Router>
        <Navigation />
        <Alert notifications={flashAlerts} />
        <Route path="/" exact render={() => <EntryList filter="unread" />} />
        <Route path="/unread" exact render={() => <EntryList filter="unread" />} />
        <Route path="/read" exact render={() => <EntryList filter="read" />} />
        <Route path="/starred" exact render={() => <EntryList filter="starred" />} />
        <Route path="/feeds" component={Feeds} />
      </Router>
    </>
  );
};

App.propTypes = {
  flashAlerts: PropTypes.array
};

export default App;
