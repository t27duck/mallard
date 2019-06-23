import React, { Component } from 'react';
import { getRequest } from '../shared/fetch';

class Feeds extends Component {
  constructor(props) {
    super(props);
    this.state = {
      feeds: [],
      feedUrl: ''
    };
  }

  componentDidMount() {
    this.fetchFeeds();
  }

  fetchFeeds = () => {
    const url = '/feeds/list';
    getRequest(url, data => {
      this.setState({ feeds: data.feeds });
    });
  };

  handleFeedUrlChange(event) {
    this.setState({ feedUrl: event.target.value });
  }

  render() {
    const { feeds } = this.state;
    const { feedUrl } = this.state;

    return (
      <div className="container">
        <h2>Feeds</h2>
        <form>
          <div className="form-row align-items-center">
            <div className="col-auto">
              <input
                type="text"
                className="form-control mb-2"
                placeholder="Feed URL"
                value={feedUrl}
                onChange={event => {
                  this.handleFeedUrlChange(event);
                  event.preventDefault();
                }}
              />
            </div>
            <div className="col-auto">
              <button type="submit" className="btn btn-primary mb-2">
                Submit
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
                  <button type="button" className="btn btn-primary">
                    Fetch
                  </button>
                  <button type="button" className="btn btn-warning">
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
