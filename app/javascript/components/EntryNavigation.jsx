import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { fetchEntry } from '../redux/entry_list';

class EntryNavigation extends Component {
  componentDidMount() {
    window.addEventListener('keydown', this.handleKeyEvent, false);
  }

  componentWillUnmount() {
    window.removeEventListener('keydown', this.handleKeyEvent, false);
  }

  handleKeyEvent = event => {
    switch (event.keyCode) {
      case 74: // j
        this.handleNextPrev(1);
        break;
      case 75: // k
        this.handleNextPrev(-1);
        break;
      default:
    }
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

  render() {
    return (
      <div className="float-right">
        <a
          href="#"
          className="btn btn-primary"
          onClick={event => {
            event.preventDefault();
            this.handleNextPrev(-1);
          }}
        >
          &laquo; Prev
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
          Next &raquo;
        </a>
      </div>
    );
  }
}

EntryNavigation.propTypes = {
  _fetchEntry: PropTypes.func.isRequired,
  entries: PropTypes.array.isRequired,
  selectedIndex: PropTypes.number.isRequired
};

const mapStateToProps = state => ({
  entries: state.entryList.entries,
  selectedIndex: state.entryList.selectedIndex
});

export default connect(
  mapStateToProps,
  {
    _fetchEntry: fetchEntry
  }
)(EntryNavigation);
