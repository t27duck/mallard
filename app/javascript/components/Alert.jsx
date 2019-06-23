import React from 'react';
import PropTypes from 'prop-types';

const alertType = typeString => {
  let isDanger = typeString.includes('error');
  isDanger = isDanger || typeString.includes('alert');

  return isDanger ? 'danger' : 'primary';
};

const Alert = props => {
  const { notification } = props;

  if (Object.getOwnPropertyNames(notification).length === 0) {
    return null;
  }

  return (
    <div className="alerts">
      <div className={`alert alert-${alertType(notification.type)}`}>{notification.message}</div>
    </div>
  );
};

Alert.propTypes = {
  notification: PropTypes.object
};

export default Alert;
