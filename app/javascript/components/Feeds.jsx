import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { fetchFeeds, addFeed, deleteFeed, fetchFeed } from '../redux/feed_manager';

class Feeds extends Component {
  constructor(props) {
    super(props);
    this.state = {
      feedUrl: ''
    };
  }

  componentDidMount() {
    const { _fetchFeeds } = this.props;
    _fetchFeeds();
  }

  handleFeedUrlChange = event => {
    this.setState({ feedUrl: event.target.value });
  };

  submitCreateFeed = () => {
    const { feedUrl } = this.state;
    const { _addFeed } = this.props;

    if (feedUrl === '') {
      return;
    }

    _addFeed({ url: feedUrl });
  };

  fetchFeed = feedId => {
    const { _fetchFeed } = this.props;
    _fetchFeed(feedId);
  };

  deleteFeed = feedId => {
    const { _deleteFeed } = this.props;
    _deleteFeed(feedId);
  };

  render() {
    const { feeds } = this.props;
    const { feedUrl } = this.state;

    return (
      <div className="container">
        <h2>Feeds</h2>
        <form
          onSubmit={event => {
            event.preventDefault();
            this.submitCreateFeed();
          }}
        >
          <div className="form-row align-items-center">
            <div className="col-auto">
              <input
                type="text"
                className="form-control mb-2"
                placeholder="Feed URL"
                value={feedUrl}
                onChange={event => {
                  event.preventDefault();
                  this.handleFeedUrlChange(event);
                }}
              />
            </div>
            <div className="col-auto">
              <button type="submit" className="btn btn-primary mb-2">
                Add Feed
              </button>
            </div>
          </div>
        </form>
        <table className="table table-striped">
          <thead>
            <tr>
              <th>Feed</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {feeds.map(feed => (
              <tr key={`feed-${feed.id}`}>
                <td>{feed.title}</td>
                <td>
                  <button
                    type="button"
                    className="btn btn-primary"
                    onClick={event => {
                      event.preventDefault();
                      this.fetchFeed(feed.id);
                    }}
                  >
                    Fetch
                  </button>
                  <button
                    type="button"
                    className="btn btn-warning"
                    data-confirm="Are you sure you want to delete this feed?"
                    onClick={event => {
                      event.preventDefault();
                      this.deleteFeed(feed.id);
                    }}
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  }
}

Feeds.propTypes = {
  _fetchFeeds: PropTypes.func,
  _fetchFeed: PropTypes.func,
  _addFeed: PropTypes.func,
  _deleteFeed: PropTypes.func,
  feeds: PropTypes.array
};

const mapStateToProps = state => ({ feeds: state.feedManager.feeds });

export default connect(
  mapStateToProps,
  { _fetchFeeds: fetchFeeds, _addFeed: addFeed, _deleteFeed: deleteFeed, _fetchFeed: fetchFeed }
)(Feeds);
