import React, { Component } from 'react';
import Alert from './Alert';
import { getRequest, postRequest } from '../shared/fetch';

class Feeds extends Component {
  constructor(props) {
    super(props);
    this.state = {
      feeds: [],
      feedUrl: '',
      notification: {}
    };
  }

  componentDidMount() {
    this.fetchFeeds();
  }

  fetchFeeds = () => {
    getRequest('/feeds/list', data => {
      this.setState({ feeds: data.feeds });
    });
  };

  handleFeedUrlChange = event => {
    this.setState({ feedUrl: event.target.value });
  };

  submitCreateFeed = () => {
    const { feedUrl } = this.state;

    if (feedUrl === '') {
      return;
    }

    postRequest('/feeds', 'POST', { url: feedUrl }, data => {
      this.setState({ notification: data.alert, feedUrl: '' });
    });
  };

  fetchFeed = feedId => {
    const url = `/feeds/${feedId}/fetch`;

    getRequest(url, data => {
      this.setState({ notification: data.alert });
    });
  };

  deleteFeed = feedId => {
    const url = `/feeds/${feedId}`;

    postRequest(url, 'DELETE', {}, data => {
      this.setState({ notification: data.alert });
      this.fetchFeeds();
    });
  };

  render() {
    const { feeds } = this.state;
    const { feedUrl } = this.state;
    const { notification } = this.state;

    return (
      <div className="container">
        <h2>Feeds</h2>
        <Alert notification={notification} />
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

export default Feeds;
