import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { fetchEntries, clearEntries, fetchEntry } from '../redux/entry_list';

class EntryList extends Component {
  constructor(props) {
    super(props);
    this.state = { entryHeight: 0 };
  }

  componentDidMount() {
    const { _fetchEntries, _clearEntries, filter } = this.props;
    _clearEntries();
    _fetchEntries(filter);
    this.updateDimensions();
    window.addEventListener('resize', this.updateDimensions);
  }

  componentWillUnmount() {
    window.removeEventListener('resize', this.updateDimensions);
  }

  updateDimensions = () => {
    this.setState({ entryHeight: window.innerHeight - 135 });
  };

  title = () => {
    const { filter } = this.props;
    return `${filter.charAt(0).toUpperCase()}${filter.slice(1)} Entries`;
  };

  handleEntryClick = entryId => {
    const { entries, _fetchEntry } = this.props;
    const newIndex = entries.findIndex(entry => entry.id === entryId);

    if (newIndex === -1) {
      return;
    }

    _fetchEntry(newIndex, entryId);
  };

  handleNextPrev = value => {
    const { selectedIndex, entries, _fetchEntry } = this.props;
    const entrySize = entries.length;
    const newIndex = selectedIndex + value;

    if (newIndex >= entrySize || newIndex < 0) {
      return;
    }

    const entryId = entries[newIndex].id;

    _fetchEntry(newIndex, entryId);
  };

  entryBody = () => {
    const { viewedEntry } = this.props;

    return (
      <div className="card-body">
        <div className="card-title clearfix">
          <div className="float-left">
            <a href="#" className="btn btn-primary">
              Mark Unread
            </a>
            &nbsp;
            <a href="#" className="btn btn-primary">
              Star
            </a>
          </div>
          <div className="float-right">
            <a href="#" className="btn btn-primary">
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
  };

  render() {
    const { entries, selectedIndex } = this.props;
    const { entryHeight } = this.state;

    return (
      <div className="container-fluid">
        <div className="clearfix">
          <div className="float-left">
            <h2>{this.title()}</h2>
          </div>
          <div className="float-right">
            <a
              href="#"
              className="btn btn-primary"
              onClick={event => {
                event.preventDefault();
                this.handleNextPrev(-1);
              }}
            >
              Prev
            </a>
            &nbsp;
            <a
              href="#"
              className="btn btn-primary"
              onClick={event => {
                event.preventDefault();
                this.handleNextPrev(1);
              }}
            >
              Next
            </a>
          </div>
        </div>
        <div id="entry-list" style={{ height: `${entryHeight}px` }}>
          {entries.map((entry, index) => (
            <div className="card" key={`entry-${entry.id}`} id={`entry-${entry.id}`}>
              <div
                className="card-header"
                onClick={() => {
                  this.handleEntryClick(entry.id);
                }}
              >
                {entry.title}
              </div>
              {selectedIndex === index && this.entryBody()}
            </div>
          ))}
        </div>
      </div>
    );
  }
}

EntryList.propTypes = {
  _fetchEntries: PropTypes.func.isRequired,
  _clearEntries: PropTypes.func.isRequired,
  _fetchEntry: PropTypes.func.isRequired,
  entries: PropTypes.array.isRequired,
  viewedEntry: PropTypes.object.isRequired,
  selectedIndex: PropTypes.number.isRequired,
  filter: PropTypes.string.isRequired
};

const mapStateToProps = state => ({
  entries: state.entryList.entries,
  selectedIndex: state.entryList.selectedIndex,
  viewedEntry: state.entryList.viewedEntry
});

export default connect(
  mapStateToProps,
  { _fetchEntries: fetchEntries, _clearEntries: clearEntries, _fetchEntry: fetchEntry }
)(EntryList);
