import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import Navigation from './Navigation';
import PostList from './PostList';
import Feeds from './Feeds';

class App extends Component {
  render() {
    return (
      <>
        <Router>
          <Navigation />
          <Route path="/" exact component={PostList} />
          <Route path="/feeds" component={Feeds} />
        </Router>
      </>
    );
  }
}

export default App;
