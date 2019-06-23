import React from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import Navigation from './Navigation';
import PostList from './PostList';
import Feeds from './Feeds';

const App = () => (
  <>
    <Router>
      <Navigation />
      <Route path="/" exact render={() => <PostList filter="unread" />} />
      <Route path="/feeds" component={Feeds} />
    </Router>
  </>
);

export default App;
