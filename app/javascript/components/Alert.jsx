import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { setNotificationsWithTimers } from '../redux/notifications';

const alertType = typeString => {
  let isDanger = typeString.includes('error');
  isDanger = isDanger || typeString.includes('alert');

  return isDanger ? 'danger' : 'primary';
};

class Alert extends React.Component {
  componentDidMount() {
    const { _setNotificationsWithTimers, notifications } = this.props;

    _setNotificationsWithTimers(notifications);
  }

  render() {
    const { notifications } = this.props;
    const filteredNotifications = notifications.filter(el => el.message !== '');

    return (
      filteredNotifications.length > 0 && (
        <div className="alerts">
          {filteredNotifications.map((alert, index) => (
            <div key={index} className={`alert alert-${alertType(alert.type)}`}>
              {alert.message}
            </div>
          ))}
        </div>
      )
    );
  }
}

Alert.propTypes = {
  notifications: PropTypes.array.isRequired,
  _setNotificationsWithTimers: PropTypes.func.isRequired
};

const mapStateToProps = state => ({
  notifications: state.notifications
});

export default connect(
  mapStateToProps,
  { _setNotificationsWithTimers: setNotificationsWithTimers }
)(Alert);
