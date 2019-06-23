import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { getRequest, postRequest } from '../shared/fetch';

class PostList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      entries: []
    };
  }

  componentDidMount() {
    this.fetchEntries();
  }

  fetchEntries = () => {
    getRequest('/entries/list', data => {
      this.setState({ feeds: data.feeds });
    });
  };

  render() {
    return null;
  }
}

PostList.propTypes = {
  filter: PropTypes.string
};

export default PostList;
