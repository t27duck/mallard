import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import EntryNavigation from './EntryNavigation';
import EntryBody from './EntryBody';
import EntrySearchAndPagination from './EntrySearchAndPagination';
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
    this.setState({ entryHeight: window.innerHeight - this.entryHeightOffset() });
  };

  entryHeightOffset = () => (this.enableSearch() ? 185 : 135);

  enableSearch = () => {
    const { filter } = this.props;
    return filter === 'read';
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

  render() {
    const { entries, filter, selectedIndex } = this.props;
    const { entryHeight } = this.state;

    return (
      <div className="container-fluid">
        <div className="clearfix">
          <div className="float-left">
            <h2>{this.title()}</h2>
          </div>
          {entries.length > 0 && <EntryNavigation />}
        </div>
        {this.enableSearch() && <EntrySearchAndPagination filter={filter} />}
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
              {selectedIndex === index && <EntryBody />}
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
  selectedIndex: PropTypes.number.isRequired,
  filter: PropTypes.string.isRequired
};

const mapStateToProps = state => ({
  entries: state.entryList.entries,
  selectedIndex: state.entryList.selectedIndex
});

export default connect(
  mapStateToProps,
  {
    _fetchEntries: fetchEntries,
    _clearEntries: clearEntries,
    _fetchEntry: fetchEntry
  }
)(EntryList);
