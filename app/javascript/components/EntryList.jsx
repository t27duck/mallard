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
    const { filter } = this.props;

    getRequest(`/entries/${filter}`, entries => {
      this.setState({ entries });
    });
  };

  render() {
    const { entries } = this.state;
    return (
      <>
        {entries.map(entry => (
          <div key={`entry-${entry.id}`}>{entry.title}</div>
        ))}
      </>
    );
  }
}

PostList.propTypes = {
  filter: PropTypes.string
};

export default PostList;
