import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { updateEntry } from '../redux/entry_list';

class EntryBody extends Component {
  handleEntryUpdate = (entryId, params) => {
    const { _updateEntry } = this.props;
    _updateEntry(entryId, { entry: params });
  };

  render() {
    const { viewedEntry } = this.props;
    const { read, starred } = viewedEntry;
    return (
      <div className="card-body">
        <div className="card-title clearfix">
          <div className="float-left">
            <a
              href="#"
              className="btn btn-primary"
              onClick={event => {
                event.preventDefault();
                this.handleEntryUpdate(viewedEntry.id, { read: !read });
              }}
            >
              Mark {read ? 'Unread' : 'Read'}
            </a>
            &nbsp;
            <a
              href="#"
              className="btn btn-primary"
              onClick={event => {
                event.preventDefault();
                this.handleEntryUpdate(viewedEntry.id, { starred: !starred });
              }}
            >
              {starred ? 'Unstar' : 'Star'}
            </a>
          </div>
          <div className="float-right">
            <a
              className="btn btn-primary"
              href={viewedEntry.url}
              rel="noreferrer noopener"
              target="_blank"
            >
              View
            </a>
          </div>
        </div>
        <h6 className="card-subtitle mb-2 text-muted">
          by {viewedEntry.author} at {viewedEntry.published_at}
        </h6>
        <div className="card-text" dangerouslySetInnerHTML={{ __html: viewedEntry.content }} />
      </div>
    );
  }
}

EntryBody.propTypes = {
  _updateEntry: PropTypes.func.isRequired,
  viewedEntry: PropTypes.object.isRequired
};

const mapStateToProps = state => ({
  viewedEntry: state.entryList.viewedEntry
});

export default connect(
  mapStateToProps,
  {
    _updateEntry: updateEntry
  }
)(EntryBody);
