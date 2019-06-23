import React from 'react';
import { Link } from 'react-router-dom';

const Navigation = () => (
  <nav className="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
    <Link className="navbar-brand" to="/">
      Mallard
    </Link>
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
      <ul className="navbar-nav mr-auto">
        <li className="nav-item active">
          <Link className="nav-link" to="/">
            Unread
          </Link>
        </li>
        <li className="nav-item">
          <Link className="nav-link" to="/read">
            Read
          </Link>
        </li>
        <li className="nav-item">
          <Link className="nav-link" to="/starred">
            Starred
          </Link>
        </li>
        <li className="nav-item">
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
    </div>
  </nav>
);

export default Navigation;
