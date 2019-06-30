import React from 'react';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';

const Navigation = props => {
  const { isSignedIn, totalUnread, totalStarred } = props;
  return (
    <nav className="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
      <a className="navbar-brand" href="/">
        Mallard
      </a>
      <button
        className="navbar-toggler"
        type="button"
        data-toggle="collapse"
        data-target="#navbar"
        aria-controls="navbart"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span className="navbar-toggler-icon" />
      </button>

      <div className="collapse navbar-collapse" id="navbar">
        {isSignedIn && (
          <>
            <ul className="navbar-nav mr-auto">
              <li className="nav-item active">
                <Link className="nav-link" to="/">
                  Unread <span className="badge badge-light">{totalUnread}</span>
                </Link>
              </li>
              <li className="nav-item active">
                <Link className="nav-link" to="/read">
                  Read
                </Link>
              </li>
              <li className="nav-item active">
                <Link className="nav-link" to="/starred">
                  Starred <span className="badge badge-light">{totalStarred}</span>
                </Link>
              </li>
              <li className="nav-item active">
                <Link className="nav-link" to="/feeds">
                  Feeds
                </Link>
              </li>
            </ul>
            <span className="navbar-text">
              <a href="/users/sign_out" data-confirm="Are you sure?">
                Logout
              </a>
            </span>
          </>
        )}
      </div>
    </nav>
  );
};

const mapStateToProps = state => ({
  isSignedIn: state.isSignedIn,
  totalUnread: state.entryList.totalUnread,
  totalStarred: state.entryList.totalStarred
});

const ConnectedNavigation = connect(mapStateToProps)(Navigation);

Navigation.propTypes = {
  isSignedIn: PropTypes.bool,
  totalUnread: PropTypes.number,
  totalStarred: PropTypes.number
};

export default ConnectedNavigation;
