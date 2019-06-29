import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { fetchEntries } from '../redux/entry_list';

class EntrySearchAndPagination extends Component {
  constructor(props) {
    super(props);
    this.state = { page: 0, search: '' };
  }

  totalPages = () => {
    const { total } = this.props;

    return Math.ceil(total / 20);
  };

  handlePagination = value => {
    const { page, search } = this.state;
    const { filter, _fetchEntries } = this.props;
    let newPage = page + value;

    if (newPage < 0) {
      newPage = 0;
    }

    if (newPage > this.totalPages() - 1) {
      newPage = this.totalPages() - 1;
    }

    this.setState({ page: newPage });

    _fetchEntries(filter, newPage, search);
  };

  handleSearchChange = event => {
    this.setState({ search: event.target.value });
  };

  handleSearchSubmit = () => {
    const { search } = this.state;
    const { filter, _fetchEntries } = this.props;

    this.setState({ page: 0 });

    _fetchEntries(filter, 0, search);
  };

  render() {
    const { page, search } = this.state;
    return (
      <div className="clearfix">
        <div className="float-left">
          <form
            onSubmit={event => {
              event.preventDefault();
              this.handleSearchSubmit();
            }}
          >
            <div className="form-row">
              <div className="input-group input-group-sm">
                <input
                  type="text"
                  className="form-control"
                  placeholder="Title Search"
                  value={search}
                  onChange={event => {
                    event.preventDefault();
                    this.handleSearchChange(event);
                  }}
                />
                <div className="input-group-append">
                  <button type="submit" className="btn btn-primary">
                    Search
                  </button>
                </div>
              </div>
            </div>
          </form>
        </div>
        <div className="float-right">
          <nav>
            <ul className="pagination pagination-sm">
              <li className="page-item">
                <a
                  href="#"
                  className="page-link"
                  onClick={event => {
                    event.preventDefault();
                    this.handlePagination(-1);
                  }}
                >
                  &laquo; Prev
                </a>
              </li>
              <li className="page-item">
                <a className="page-link">
                  {page + 1} / {this.totalPages()}
                </a>
              </li>
              <li className="page-item">
                <a
                  href="#"
                  className="page-link"
                  onClick={event => {
                    event.preventDefault();
                    this.handlePagination(1);
                  }}
                >
                  Next &raquo;
                </a>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    );
  }
}

EntrySearchAndPagination.propTypes = {
  _fetchEntries: PropTypes.func.isRequired,
  total: PropTypes.number.isRequired,
  filter: PropTypes.string.isRequired
};

const mapStateToProps = state => ({
  total: state.entryList.total
});

export default connect(
  mapStateToProps,
  {
    _fetchEntries: fetchEntries
  }
)(EntrySearchAndPagination);
