import React from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import Navigation from './Navigation';
import EntryList from './EntryList';
import Feeds from './Feeds';

const App = () => (
  <>
    <Router>
      <Navigation />
      <Route path="/" exact render={() => <EntryList filter="unread" />} />
      <Route path="/unread" exact render={() => <EntryList filter="unread" />} />
      <Route path="/read" exact render={() => <EntryList filter="read" />} />
      <Route path="/starred" exact render={() => <EntryList filter="starred" />} />
      <Route path="/feeds" component={Feeds} />
    </Router>
  </>
);

export default App;
